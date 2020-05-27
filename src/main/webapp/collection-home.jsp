<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Collection home JSP
  -
  - Attributes required:
  -    collection  - Collection to render home page for
  -    community   - Community this collection is in
  -    admin_button - Boolean, show admin 'edit' button
  -    editor_button - Boolean, show collection editor (edit submitters, item mapping) buttons
  -  see components/item-list.jsp
  -    show.items - Boolean, show item list
  -    browse.info - BrowseInfo, item list
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="org.dspace.content.*" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>

<%
    // Retrieve attributes
    Collection collection = (Collection) request.getAttribute("dspaceObject");
    // used by components/item-list.jsp
    // used by components/button-list.jsp
    request.setAttribute("dspaceObject", collection);

    // Put the metadata values into guaranteed non-null variables
    String name = collection.getMetadata("name");

    Boolean admin_button = request.getAttribute("admin_button") != null;
    boolean showStatsLink = admin_button || ConfigurationManager.getBooleanProperty("report.public");
%>

<dspace:layout locbar="commLink" title="<%= name %>">
    <div class="col-md-9 main">
        <div class="well">
            <h2><%= name %>
                <% if (showStatsLink) { %>
                <a class="statisticsLink btn btn-info"
                   href="<%= request.getContextPath() %>/handle/<%= collection.getHandle() %>/statistics"><fmt:message
                        key="jsp.collection-home.display-statistics"/></a>
                <% } %>
            </h2>
        </div>
        <dspace:include page="/components/item-list.jsp"/>
    </div>

    <div class="col-md-3 sidebar">
            <dspace:include page="/components/collection-admin-tools.jsp"/>

            <dspace:include page="/components/search-buttons.jsp"/>

            <dspace:include page="/components/browse-buttons.jsp"/>
    </div>

</dspace:layout>

