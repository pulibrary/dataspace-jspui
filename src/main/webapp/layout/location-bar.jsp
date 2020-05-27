<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Location bar component
  -
  - This component displays the "breadcrumb" style navigation aid at the top
  - of most screens.
  -
  - Uses request attributes set in org.dspace.app.webui.jsptag.Layout, and
  - hence must only be used as part of the execution of that tag.  Plus,
  - dspace.layout.locbar should be verified to be true before this is included.
  -
  -  dspace.layout.parenttitles - List of titles of parent pages
  -  dspace.layout.parentlinks  - List of URLs of parent pages, empty string
  -                               for non-links
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
    <%
        List<String> handles,  names;
        handles = (List<String>) request.getAttribute("dspaceObject.parents.handles");
        names = (List<String>) request.getAttribute("dspaceObject.parents.names");

        if (handles != null && ! handles.isEmpty()) {

    %>
    <ol class="breadcrumb btn-success">
        <li>
                <a href="<%= request.getContextPath() %>">
                <span class="glyphicon glyphicon-home"> </span>
            </a>
        </li>

    <%
            for (int i = handles.size() -1; i>=0;  i--) {
                String path = request.getContextPath() + "/handle/" + handles.get(i);
                String name = names.get(i);
                %>   <li><a href="<%= path %>"><%= name %></a></li> <%
            }
    %>

    </ol>
<%
    }
%>
