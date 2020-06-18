/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.app.webui.components;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dspace.authorize.AuthorizeException;
import org.dspace.content.Collection;
import org.dspace.core.Context;
import org.dspace.plugin.CollectionHomeProcessor;
import org.dspace.plugin.PluginException;


/**
 * This class obtains item list of the given collection by
 * implementing the CollectionHomeProcessor.
 * 
 * @author Keiji Suzuki
 *
 */
public class CollectionItemList implements CollectionHomeProcessor
{
    /**
     * blank constructor - does nothing.
     *
     */
    public CollectionItemList()
    {
        
    }

    /* (non-Javadoc)
     * @see org.dspace.plugin.CommunityHomeProcessor#process(org.dspace.core.Context, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.dspace.content.Community)
     */
    public void process(Context context, HttpServletRequest request, HttpServletResponse response, Collection collection)
            throws PluginException, AuthorizeException {
        DSpaceObjectItemList.process(context, request, response, collection);
    }
}
