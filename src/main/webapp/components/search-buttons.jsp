<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page import="org.dspace.content.DSpaceObject" %>
<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.core.Constants" %>
<%@ page import="org.dspace.content.Item" %>
<%@ page import="org.dspace.content.Collection" %>

<%
    // Retrieve attributes
    DSpaceObject searchThis = (DSpaceObject) request.getAttribute("dspaceObject");
    if (searchThis != null) {
        if (searchThis.getType() != Constants.COMMUNITY) {
            while (searchThis != null && searchThis.getType() != Constants.COLLECTION) {
                searchThis = searchThis.getParentObject();
            }
        }
    }
%>

<div class="search-buttons panel">
    <div class="row panel-heading btn-primary">
        <div class="btn-lbl btn-block"><fmt:message key="jsp.search.title"/></div>
    </div>

    <div class="row panel-body btn-default">

        <%-- Search Box --%>
        <form method="get" action="<%= request.getContextPath() %>/simple-search">
            <div>

                <input type="text"
                       placeholder="<fmt:message key="jsp.general.search.suggest"/>" name="query" id="tequery"
                       size="20"/>

                <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></button>

            </div>
            <% if (searchThis != null) { %>
            <div>
                <select id="tlocation" name="location">
                    <option value="/"><fmt:message key="jsp.general.genericScope"/></option>

                    <option value="<%= searchThis.getHandle()%>" selected="selected">
                        <% if (searchThis.getType() == Constants.COMMUNITY) { %>
                        This Community
                        <% } else { %>
                        This Collection
                        <% } %>
                    </option>

                </select>

            </div>
            <% } %>
            <div>
                <label>
                    <% String advLink = request.getContextPath()  + "/simple-search";
                        if (searchThis != null ) {
                            advLink = advLink + "?location=" + searchThis.getHandle();
                        }
                    %>
                    <!-- need to make sure we propagate searchThis  -->
                    <a href="<%= advLink %>">
                        Advanced Search </a>
                </label>
            </div>
        </form>

    </div>
</div>

