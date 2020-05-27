<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page import="org.dspace.content.DSpaceObject" %>
<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.core.Constants" %>

<%
    // Retrieve attributes
    DSpaceObject searchThis = (DSpaceObject) request.getAttribute("dspaceObject");
    if (searchThis == null) {
        return;
    } else {
        if (searchThis.getType() != Constants.COMMUNITY) {
            while (searchThis != null && searchThis.getType() != Constants.COLLECTION) {
                searchThis = searchThis.getParentObject();
            }
        }
    }

    // get the browse indices
    BrowseIndex[] bis = BrowseIndex.getBrowseIndices();
%>

<div class="browse-buttons panel">
    <div class="row panel-heading btn-primary">
        <div class="btn-lbl btn-block"><fmt:message key="jsp.general.browse"/></div>
    </div>
    <div class="row panel-body btn-default">
        <%-- Insert the dynamic list of browse options --%>
        <% for (BrowseIndex bi : bis) {
            String key = "browse.menu." + bi.getName();
        %>
        <form method="get" class="<%= bi.getName() %>"
              action="<%= request.getContextPath() %>/handle/<%= searchThis.getHandle() %>/browse">
            <input type="hidden" name="type" value="<%= bi.getName() %>"/>

            <input class="btn btn-default btn-block" type="submit" name="submit_browse"
                   value="<fmt:message key="<%= key %>"/>"/>
        </form>
        <% } %>
    </div>
</div>
