<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - list item in table based on bwrose.info
  -
  - Attributes required:
  -    dspaceObject  - collection or community dspace object
  -    show.items - Boolean, show item list
  -    browse.info - BrowseInfo, item list
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.browse.BrowseInfo" %>
<%@ page import="org.dspace.content.*" %>

<%
    // Retrieve attributes
    DSpaceObject dspaceObject = (DSpaceObject) request.getAttribute("dspaceObject");

    // get the browse indices
    BrowseIndex[] bis = BrowseIndex.getBrowseIndices();

    Boolean show_items = (Boolean) request.getAttribute("show.items");
%>

<div class="item-list">

    <% if (!show_items) { %>
        <h3> <fmt:message key="jsp.itemlist.empty"/> </h3>
<% } else {
        BrowseInfo bi = (BrowseInfo) request.getAttribute("browse.info");
        BrowseIndex bix = bi.getBrowseIndex();

        // prepare the next and previous links
        String linkBase = request.getContextPath() + "/handle/" + dspaceObject.getHandle();

        String next = linkBase;
        String prev = linkBase;

        if (bi.hasNextPage()) {
            next = next + "?offset=" + bi.getNextOffset();
        }

        if (bi.hasPrevPage()) {
            prev = prev + "?offset=" + bi.getPrevOffset();
        }

        String bi_name_key = "browse.menu." + bi.getSortOption().getName();
        String so_name_key = "browse.order." + (bi.isAscending() ? "asc" : "desc");
    %>


    <%-- give us the top report on what we are looking at --%>
    <fmt:message var="bi_name" key="<%= bi_name_key %>"/>
    <fmt:message var="so_name" key="<%= so_name_key %>"/>
    <div class="browse_range">
        <fmt:message key="jsp.collection-home.content.range">
            <fmt:param value="${bi_name}"/>
            <fmt:param value="${so_name}"/>
            <fmt:param value="<%= Integer.toString(bi.getStart()) %>"/>
            <fmt:param value="<%= Integer.toString(bi.getFinish()) %>"/>
            <fmt:param value="<%= Integer.toString(bi.getTotal()) %>"/>
        </fmt:message>
    </div>

    <%--  do the top previous and next page links --%>
    <div class="prev-next-links">
        <%
            if (bi.hasPrevPage()) {
        %>
        <a href="<%= prev %>"><fmt:message key="browse.full.prev"/></a>&nbsp;
        <%
            }

            if (bi.hasNextPage()) {
        %>
        &nbsp;<a href="<%= next %>"><fmt:message key="browse.full.next"/></a>
        <%
            }
        %>
    </div>

    <%-- output the results using the browselist tag --%>
    <%
        if (bix.isMetadataIndex()) {
    %>
    <dspace:browselist browseInfo="<%= bi %>" emphcolumn="<%= bix.getMetadata() %>"/>
    <%
    } else {
    %>
    <dspace:browselist browseInfo="<%= bi %>" emphcolumn="<%= bix.getSortOption().getMetadata() %>"/>
    <%
        }
    %>

    <%-- give us the bottom report on what we are looking at --%>
    <div class="browse_range">
        <fmt:message key="jsp.collection-home.content.range">
            <fmt:param value="${bi_name}"/>
            <fmt:param value="${so_name}"/>
            <fmt:param value="<%= Integer.toString(bi.getStart()) %>"/>
            <fmt:param value="<%= Integer.toString(bi.getFinish()) %>"/>
            <fmt:param value="<%= Integer.toString(bi.getTotal()) %>"/>
        </fmt:message>
    </div>

    <%--  do the bottom previous and next page links --%>
    <div class="prev-next-links">
        <%
            if (bi.hasPrevPage()) {
        %>
        <a href="<%= prev %>"><fmt:message key="browse.full.prev"/></a>&nbsp;
        <%
            }

            if (bi.hasNextPage()) {
        %>
        &nbsp;<a href="<%= next %>"><fmt:message key="browse.full.next"/></a>
        <%
            }
        %>
    </div>
<%
        } // end of if (show_title)
%>
</div>

