<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page import="org.dspace.content.Collection" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.content.DSpaceObject" %>
<%@ page import="org.dspace.app.webui.servlet.admin.EditCommunitiesServlet" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.browse.ItemCounter" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>

<%
    Collection[] collections =
            (Collection[]) request.getAttribute("collections");
    Community[] subcommunities =
            (Community[]) request.getAttribute("subcommunities");

    DSpaceObject dspaceObject = (Community) request.getAttribute("dspaceObject");

    Boolean remove_button = request.getAttribute("remove_button") != null;

    ItemCounter ic = new ItemCounter(UIUtil.obtainContext(request));

    Boolean showStrength = ConfigurationManager.getBooleanProperty("webui.strengths.show");

    if (subcommunities.length != 0) {
%>
<div class="community-list">
    <h3><fmt:message key="jsp.community-home.heading3"/></h3>

    <div class="list-group">
        <%
            for (int j = 0; j < subcommunities.length; j++) {
        %>
        <div class="list-group-item">
            <div>
                <h4 class="list-group-item-heading"><a
                        href="<%= request.getContextPath() %>/handle/<%= subcommunities[j].getHandle() %>">
                    <%= subcommunities[j].getMetadata("name") %>
                </a>
                <% if (showStrength) { %>
                    <span class="badge pull-right"> <%= ic.getCount(subcommunities[j])%></span>
                <% } %>
                <% if (remove_button) { %>
                    <form class="btn-group" method="post"
                          action="<%=request.getContextPath()%>/tools/edit-communities">
                        <input type="hidden" name="parent_community_id" value="<%= dspaceObject.getID() %>"/>
                        <input type="hidden" name="community_id" value="<%= subcommunities[j].getID() %>"/>
                        <input type="hidden" name="action" value="<%=EditCommunitiesServlet.START_DELETE_COMMUNITY%>"/>
                        <button type="submit" class="btn btn-xs btn-danger"><span
                                class="glyphicon glyphicon-trash"></span></button>
                    </form>
                    <% } %>
                </h4>
                <p class="collectionDescription"><%= subcommunities[j].getMetadata("short_description") %>
                </p>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
<%
    }
%>

<%
    if (collections.length != 0) {
%>
<div class="collection-list">

    <%-- <h2>Collections in this dspaceObject</h2> --%>
    <h3><fmt:message key="jsp.community-home.heading2"/></h3>

    <div class="list-group">
        <%
            for (int i = 0; i < collections.length; i++) {
        %>
        <div class="list-group-item ">

            <div>
                <h4 class="list-group-item-heading"><a
                        href="<%= request.getContextPath() %>/handle/<%= collections[i].getHandle() %>">
                    <%= collections[i].getMetadata("name") %>
                </a>
                <% if (showStrength) { %>
                    <span class="badge pull-right"> <%= ic.getCount(collections[i])%></span>
                <% } %>

                <% if (remove_button) { %>
                    <form class="btn-group" method="post"
                          action="<%=request.getContextPath()%>/tools/edit-communities">
                        <input type="hidden" name="parent_community_id" value="<%= dspaceObject.getID() %>"/>
                        <input type="hidden" name="community_id" value="<%= dspaceObject.getID() %>"/>
                        <input type="hidden" name="collection_id" value="<%= collections[i].getID() %>"/>
                        <input type="hidden" name="action"
                               value="<%=EditCommunitiesServlet.START_DELETE_COLLECTION%>"/>
                        <button type="submit" class="btn btn-xs btn-danger"><span
                                class="glyphicon glyphicon-trash"></span></button>
                    </form>
                    <% } %>
                </h4>
                <p class="collectionDescription"><%= collections[i].getMetadata("short_description") %>
                </p>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
<%
    }
%>
