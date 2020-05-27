/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 * <p/>
 * http://www.dspace.org/license/
 */
package org.dspace.app.webui.components;

import java.sql.SQLException;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Community;
import org.dspace.core.Context;


public class TopCommunitiesProcessor {
    public static void process(HttpServletRequest request) throws SQLException {
        if (request.getAttribute("top.communities") == null) {
            Context context = UIUtil.obtainContext(request);
            // Get the top communities to shows in the community list
            SortedMap<String, String> map = new TreeMap<>();
            Community[] communities = Community.findAllTop(context);
            for (Community com : communities) {
                map.put(com.getName(), com.getHandle());
            }
            request.setAttribute("top.communities", map);
            request.setAttribute("communities", communities);
        }
    }

}
