package org.dspace.app.webui.helper;

import org.dspace.core.ConfigurationManager;
import org.dspace.eperson.EPerson;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by monikam on 10/11/16.
 */
public class JSPParameter {
    HttpServletRequest request;
    public String request_path = null;
    String siteName = null, contactEmail = null;
    public EPerson currentUser = null;

    public JSPParameter(HttpServletRequest request) {
        this.request = request;
        this.request_path = request.getContextPath();
        currentUser = (EPerson) request.getAttribute("dspace.current.user");
    }

    public String puAssetPath(String relName) {
        return request_path + "/static/pu_custom/assets/public/" + relName;
    }

    public String siteName() {
        if (null == siteName)
            siteName = ConfigurationManager.getProperty("dspace.name");
        return siteName;
    }

    public String contactEmail() {
        if (null == contactEmail)
            contactEmail = ConfigurationManager.getProperty("feedback.recipient");
        return contactEmail;
    }

    public String currentNetid() {
        if (null == currentUser)
            return null;
        else
            return currentUser.getNetid();
    }

    public boolean isTestInstance() {
        String environment = ConfigurationManager.getProperty("dspace.environment");
        return  environment != null && ! environment.isEmpty() && ! environment.equalsIgnoreCase("PRODUCTION");
    }
}
