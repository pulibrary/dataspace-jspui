<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Community home JSP
  -
  - Attributes required:
  -    community             - Community to render home page for
  -    collections           - array of Collections in this community
  -    subcommunities        - array of Sub-communities in this community
  -    last.submitted.titles - String[] of titles of recently submitted items
  -    last.submitted.urls   - String[] of URLs of recently submitted items
  -    admin_button - Boolean, show admin 'edit' button
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
    DSpaceObject dspaceObject = (Community) request.getAttribute("dspaceObject");

    // used by components/item-list.jsp
    // used by components/browse-buttons.jsp
    request.setAttribute("dspaceObject", dspaceObject);

    // Put the metadata values into guaranteed non-null variables
    String name = dspaceObject.getMetadata("name");
    String intro = dspaceObject.getMetadata("introductory_text");

    String navSubClass = "";
    String navItemsClass = "active";
    String collCommHomeActiveTab = ConfigurationManager.getProperty(dspaceObject, "collHomeTab");

    // HACK: if there is an offset param value we know that we should show items tab
    String offset =  request.getParameter("offset");
    boolean showItemTab = offset != null;

    if (!showItemTab && (collCommHomeActiveTab != null) && (collCommHomeActiveTab.charAt(0) == 'C')) {
        navSubClass= "active";
        navItemsClass = "";
    }

    Boolean admin_user = request.getAttribute("editor_button") != null || request.getAttribute("add_button") != null;
    boolean showStatsLink = admin_user || ConfigurationManager.getBooleanProperty("report.public");
%>

<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<dspace:layout locbar="commLink" title="<%= name %>">
    <div class="col-md-9 main">
        <div class="well">
            <h2><%= name %>
                <% if (showStatsLink) { %>
                <a class="statisticsLink btn btn-info"
                   href="<%= request.getContextPath() %>/handle/<%= dspaceObject.getHandle() %>/statistics"><fmt:message
                        key="jsp.community-home.display-statistics"/></a>
                <% } %>
            </h2>
            <% if (StringUtils.isNotBlank(intro)) { %>
            <p>
                <%= intro %>
            </p>
            <% } %>
        </div>

        <ul class="nav nav-tabs">
            <li class="<%= navSubClass %>"><a href="#sub" data-toggle="tab">Communities<br/>Collections </a></li>
            <li class="<%= navItemsClass%>"><a href="#items" data-toggle="tab">Items</a></li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane <%= navSubClass %>" id="sub">
                <!-- nested communities and collections  -->
                <dspace:include page="/components/sub-comm-coll-lists.jsp"/>
            </div>
            <div class="tab-pane <%= navItemsClass %>" id="items">
                <!-- items in this and enclosed comm/colls -->
                <dspace:include page="/components/item-list.jsp"/>
            </div>
        </div>
    </div>

    <div class="col-md-3 sidebar">
        <%@ include file="components/community-admin-tools.jsp" %>

        <dspace:include page="/components/search-buttons.jsp"/>

        <dspace:include page="/components/browse-buttons.jsp"/>
    </div>


</dspace:layout>
