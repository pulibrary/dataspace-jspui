package org.dspace.app.webui.components;

/**
 * Created by monikam on 7/16/15.
 */

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dspace.authorize.AuthorizeException;
import org.dspace.content.Community;
import org.dspace.core.Context;
import org.dspace.plugin.CommunityHomeProcessor;
import org.dspace.plugin.PluginException;


public class CommunityItemList implements CommunityHomeProcessor {
    /**
     * blank constructor - does nothing.
     *
     */
    public CommunityItemList()
    {

    }

    /* (non-Javadoc)
     * @see org.dspace.plugin.CommunityHomeProcessor#process(org.dspace.core.Context, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.dspace.content.Community)
     */
    public void process(Context context, HttpServletRequest request, HttpServletResponse response, Community comunity)
            throws PluginException, AuthorizeException {
        DSpaceObjectItemList.process(context, request, response, comunity);
    }

}
