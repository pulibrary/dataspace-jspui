<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.app.webui.servlet.admin.EditCommunitiesServlet" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.app.webui.servlet.MyDSpaceServlet" %>

<%
    Community community = (Community) request.getAttribute("community");
    Boolean editor_button = request.getAttribute("editor_button") != null;
    Boolean add_button = request.getAttribute("add_button") != null;

%>

<% if (editor_button || add_button) { %>
<div class="admin-tools panel panel-warning">
    <div class="panel-heading">
        <fmt:message key="jsp.admintools"/>
             	<span class="pull-right">
             		<dspace:popup
                            page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.site-admin\")%>"><fmt:message
                            key="jsp.adminhelp"/></dspace:popup>
             	</span>
    </div>
    <div class="panel-body">
        <% if (editor_button) { %>
        <form method="post" action="<%=request.getContextPath()%>/tools/edit-communities">
            <input type="hidden" name="community_id" value="<%= community.getID() %>"/>
            <input type="hidden" name="action" value="<%=EditCommunitiesServlet.START_EDIT_COMMUNITY%>"/>
            <%--<input type="submit" value="Edit..." />--%>
            <input class="btn btn-default col-md-12" type="submit"
                   value="<fmt:message key="jsp.general.edit.button"/>"/>
        </form>
        <% } %>
        <% if (add_button) { %>

        <form method="post" action="<%=request.getContextPath()%>/tools/collection-wizard">
            <input type="hidden" name="community_id" value="<%= community.getID() %>"/>
            <input class="btn btn-default col-md-12" type="submit"
                   value="<fmt:message key="jsp.community-home.create1.button"/>"/>
        </form>

        <form method="post" action="<%=request.getContextPath()%>/tools/edit-communities">
            <input type="hidden" name="action" value="<%= EditCommunitiesServlet.START_CREATE_COMMUNITY%>"/>
            <input type="hidden" name="parent_community_id" value="<%= community.getID() %>"/>
            <input class="btn btn-default col-md-12" type="submit" name="submit"
                   value="<fmt:message key="jsp.community-home.create2.button"/>"/>
        </form>
        <% } %>
        <% if (editor_button) { %>
        <form method="post" action="<%=request.getContextPath()%>/mydspace">
            <input type="hidden" name="community_id" value="<%= community.getID() %>"/>
            <input type="hidden" name="step" value="<%= MyDSpaceServlet.REQUEST_EXPORT_ARCHIVE %>"/>
            <input class="btn btn-default col-md-12" type="submit"
                   value="<fmt:message key="jsp.mydspace.request.export.community"/>"/>
        </form>
        <form method="post" action="<%=request.getContextPath()%>/mydspace">
            <input type="hidden" name="community_id" value="<%= community.getID() %>"/>
            <input type="hidden" name="step" value="<%= MyDSpaceServlet.REQUEST_MIGRATE_ARCHIVE %>"/>
            <input class="btn btn-default col-md-12" type="submit"
                   value="<fmt:message key="jsp.mydspace.request.export.migratecommunity"/>"/>
        </form>
        <form method="post" action="<%=request.getContextPath()%>/dspace-admin/metadataexport">
            <input type="hidden" name="handle" value="<%= community.getHandle() %>"/>
            <input class="btn btn-default col-md-12" type="submit"
                   value="<fmt:message key="jsp.general.metadataexport.button"/>"/>
        </form>
        <% } %>
    </div>
</div>
<% } %>