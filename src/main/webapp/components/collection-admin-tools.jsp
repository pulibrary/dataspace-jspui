<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.app.webui.servlet.admin.EditCommunitiesServlet" %>
<%@ page import="org.dspace.content.DSpaceObject" %>
<%@ page import="org.dspace.app.webui.servlet.MyDSpaceServlet" %>
<%@ page import="org.dspace.eperson.Group" %>

<%
    DSpaceObject collection = (DSpaceObject) request.getAttribute("collection");
    DSpaceObject community = (DSpaceObject) request.getAttribute("community");
    Boolean editor_button = request.getAttribute("editor_button") != null;
    Boolean admin_button = request.getAttribute("admin_button") != null;
    Boolean submit_button  = request.getAttribute("can_submit_button") != null;

    Group submitters = (Group) request.getAttribute("submitters");
%>

<% if (editor_button || admin_button || submitters != null || submit_button) { %>
<div class="admin-tools panel panel-warning">
    <div class="panel-heading"><fmt:message key="jsp.admintools"/>
                <span class="pull-right"><dspace:popup
                        page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.collection-admin\")%>"><fmt:message
                        key="jsp.adminhelp"/></dspace:popup></span>
    </div>

    <div class="panel-body">
        <%  if (submit_button)
        { %>
        <form class="form-group" action="<%= request.getContextPath() %>/submit" method="post">
            <input type="hidden" name="collection" value="<%= collection.getID() %>" />
            <input class="btn btn-default col-md-12" type="submit" name="submit" value="<fmt:message key="jsp.collection-home.submit.button"/>" />
        </form>
        <%  } %>

        <% if (editor_button) { %>
        <form method="post" action="<%=request.getContextPath()%>/tools/edit-communities">
            <input type="hidden" name="collection_id" value="<%= collection.getID() %>"/>
            <input type="hidden" name="community_id" value="<%= community.getID() %>"/>
            <input type="hidden" name="action" value="<%= EditCommunitiesServlet.START_EDIT_COLLECTION %>"/>
            <input class="btn btn-default col-md-12" type="submit"
                   value="<fmt:message key="jsp.general.edit.button"/>"/>
        </form>
        <% } %>

        <% if (admin_button) { %>
            <form method="post" action="<%=request.getContextPath()%>/tools/itemmap">
                <input type="hidden" name="cid" value="<%= collection.getID() %>"/>
                <input class="btn btn-default col-md-12" type="submit"
                       value="<fmt:message key="jsp.collection-home.item.button"/>"/>
            </form>
            <% if (submitters != null) { %>
                <form method="get" action="<%=request.getContextPath()%>/tools/group-edit">
                    <input type="hidden" name="group_id" value="<%=submitters.getID()%>"/>
                    <input class="btn btn-default col-md-12" type="submit" name="submit_edit"
                           value="<fmt:message key="jsp.collection-home.editsub.button"/>"/>
                </form>
                <% } %>
                <% if (editor_button || admin_button) { %>
                    <form method="post" action="<%=request.getContextPath()%>/mydspace">
                        <input type="hidden" name="collection_id" value="<%= collection.getID() %>"/>
                        <input type="hidden" name="step" value="<%= MyDSpaceServlet.REQUEST_EXPORT_ARCHIVE %>"/>
                        <input class="btn btn-default col-md-12" type="submit"
                               value="<fmt:message key="jsp.mydspace.request.export.collection"/>"/>
                    </form>
                    <form method="post" action="<%=request.getContextPath()%>/mydspace">
                        <input type="hidden" name="collection_id" value="<%= collection.getID() %>"/>
                        <input type="hidden" name="step" value="<%= MyDSpaceServlet.REQUEST_MIGRATE_ARCHIVE %>"/>
                        <input class="btn btn-default col-md-12" type="submit"
                               value="<fmt:message key="jsp.mydspace.request.export.migratecollection"/>"/>
                    </form>
                    <form method="post" action="<%=request.getContextPath()%>/dspace-admin/metadataexport">
                        <input type="hidden" name="handle" value="<%= collection.getHandle() %>"/>
                        <input class="btn btn-default col-md-12" type="submit"
                               value="<fmt:message key="jsp.general.metadataexport.button"/>"/>
                    </form>
            <% } %>
        <% } %>
    </div>
</div>
<% } %>
