/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.app.webui.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.dspace.app.webui.util.Authenticate;
import org.dspace.app.webui.util.JSPManager;
import org.dspace.app.webui.util.UIUtil;
import org.dspace.authorize.AuthorizeException;
import org.dspace.content.DSpaceObject;
import org.dspace.core.ConfigurationManager;
import org.dspace.core.Constants;
import org.dspace.core.Context;
import org.dspace.core.LogManager;

/**
 * Base class for DSpace servlets. This manages the initialisation of a context,
 * if a context has not already been initialised by an authentication filter. It
 * also grabs the original request URL for later use.
 * <P>
 * Unlike regular servlets, DSpace servlets should override the
 * <code>doDSGet</code> and <code>doDSPost</code> methods, which provide a
 * DSpace context to work with, and handle the common exceptions
 * <code>SQLException</code> and <code>AuthorizeException</code>.
 * <code>doGet</code> and <code>doPost</code> should be overridden only in
 * special circumstances.
 * <P>
 * Note that if all goes well, the context object passed in to
 * <code>doDSGet</code> and <code>doDSPut</code> must be completed
 * <em>after</em> a JSP has been displayed, but <code>before</code> the
 * method returns. If an error occurs (an exception is thrown, or the context is
 * not completed) the context is aborted after <code>doDSGet</code> or
 * <code>doDSPut</code> return.
 * 
 * @see org.dspace.core.Context
 * 
 * @author Robert Tansley
 * @version $Revision$
 */
public class DSpaceServlet extends HttpServlet
{
    /*
     * Because the error handling is indentical for GET and POST requests, to
     * make things easier, doGet and doPost are folded into one method which
     * then "re-separates" to GET and POST. We do not override "service" since
     * we wish to allow doGet and doPost to be overridden if necessary (for
     * example, by lightweight servlets that do not need a DSpace context
     * object).
     */

    /** log4j category */
    private static Logger log = Logger.getLogger(DSpaceServlet.class);

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException
    {
        if (log.isDebugEnabled()) {
            Logger.getLogger(this.getClass()).debug("doGet");
        }
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException
    {
        if (log.isDebugEnabled()) {
            Logger.getLogger(this.getClass()).debug("doPost");
        }
        processRequest(request, response);
    }

    /**
     * Process an incoming request
     * 
     * @param request
     *            the request object
     * @param response
     *            the response object
     */
    private void processRequest(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException
    {
        Context context = null;

        // set all incoming encoding to UTF-8
        request.setCharacterEncoding("UTF-8");

        // Get the URL from the request immediately, since forwarding
        // loses that information
        UIUtil.storeOriginalURL(request);

        try
        {
            // Obtain a context - either create one, or get the one created by
            // an authentication filter
            context = UIUtil.obtainContext(request);

            // Are we resuming a previous request that was interrupted for
            // authentication?
            request = Authenticate.getRealRequest(request);

            if (log.isDebugEnabled())
            {
                log.debug(LogManager.getHeader(context, "http_request", UIUtil
                        .getRequestLogInfo(request)));
            }

            // Invoke the servlet code
            if (request.getMethod().equals("POST"))
            {
                doDSPost(context, request, response);
            }
            else
            {
                doDSGet(context, request, response);
            }
        }
        catch (SQLException se)
        {
            // For database errors, we log the exception and show a suitably
            // apologetic error
            log.warn(LogManager.getHeader(context, "database_error", se
                    .toString()), se);

            // Also email an alert
            UIUtil.sendAlert(request, se);

            JSPManager.showInternalError(request, response);
        }
        catch (AuthorizeException ae)
        {
           /*
             * somebody logged in
             * ==> we know user not allowed to do whatever she tried
             */
            /* nobody logged in && auto.explicit == true
             * ==> start explicit authentication
             *  account owners can login and might get their request through
             *  others get login prompt instead of 403
             */
            /* nobody logged in && auto.explicit == false
             * ==> authenticate error
             * account owners can try to login in by clicking the 'My DSpace' and ty again
             * others will get error page
             */
            Boolean doexplicit = ConfigurationManager.getBooleanProperty("authentication", "auto.explicit", true);
            Boolean noAccess = true;

            if (doexplicit && null == context.getCurrentUser() ) {
                noAccess = Authenticate.startAuthentication(context, request, response);
            }

            if (noAccess)
            {
                // FIXME: Log the right info?
                // Log the error
                log.info(LogManager.getHeader(context, "authorize_error", ae
                        .toString()));

                JSPManager.showAuthorizeError(request, response, ae);
            }
        } catch (Exception e) {
            // For any other exception report on error page
            // and log stack trace
            log.error(LogManager.getHeader(context, "unhandled error", e.toString()), e);
            // Also email an alert
            UIUtil.sendAlert(request, e);

            JSPManager.showInternalError(request, response);
        }
        finally
        {
            // Abort the context if it's still valid
            if ((context != null) && context.isValid())
            {
                context.abort();
            }
        }
    }

    /**
     * Process an incoming HTTP GET. If an exception is thrown, or for some
     * other reason the passed in context is not completed, it will be aborted
     * and any changes made by this method discarded when this method returns.
     * 
     * @param context
     *            a DSpace Context object
     * @param request
     *            the HTTP request
     * @param response
     *            the HTTP response
     * 
     * @throws SQLException
     *             if a database error occurs
     * @throws AuthorizeException
     *             if some authorization error occurs
     */
    protected void doDSGet(Context context, HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException,
            SQLException, AuthorizeException
    {
        // If this is not overridden, we invoke the raw HttpServlet "doGet" to
        // indicate that GET is not supported by this servlet.
        super.doGet(request, response);
    }

    /**
     * Process an incoming HTTP POST. If an exception is thrown, or for some
     * other reason the passed in context is not completed, it will be aborted
     * and any changes made by this method discarded when this method returns.
     * 
     * @param context
     *            a DSpace Context object
     * @param request
     *            the HTTP request
     * @param response
     *            the HTTP response
     * 
     * @throws SQLException
     *             if a database error occurs
     * @throws AuthorizeException
     *             if some authorization error occurs
     */
    protected void doDSPost(Context context, HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException,
            SQLException, AuthorizeException
    {
        // If this is not overridden, we invoke the raw HttpServlet "doGet" to
        // indicate that POST is not supported by this servlet.
        if (log.isDebugEnabled()) {
                    Logger.getLogger(this.getClass()).debug("doDSPost");
        }
        super.doGet(request, response);
    }


    protected void setDSpaceObjectAndHandle(Context context, HttpServletRequest request, DSpaceObject dso) throws SQLException {
        if (dso != null && request.getAttribute("dspaceObject") == null) {
            request.setAttribute("dspaceObject", dso);
            List<String> handles = new ArrayList<String>();
            List<String> names  = new ArrayList<String>();
             while (dso != null) {
                 if (dso.getType() != Constants.ITEM){
                     handles.add(dso.getHandle());
                     names.add(dso.getName());
                 }
                 dso = dso.getParentObject();
             }
            request.setAttribute("dspaceObject.parents.handles", handles);
            request.setAttribute("dspaceObject.parents.names", names);
        }
    }
}
