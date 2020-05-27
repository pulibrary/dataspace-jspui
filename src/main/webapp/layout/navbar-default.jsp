<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Default navigation bar
--%>

<%@page import="org.apache.commons.lang.StringUtils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="/WEB-INF/dspace-tags.tld" prefix="dspace" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.eperson.EPerson" %>
<%@ page import="org.dspace.app.webui.util.JSPManager" %>
<%@ page import="java.util.SortedMap" %>
<%@ page import="java.util.Map" %>

<%
    String siteName = ConfigurationManager.getProperty("dspace.name");
    String contactEmail = ConfigurationManager.getProperty("feedback.recipient");

    // Is anyone logged in?
    EPerson user = (EPerson) request.getAttribute("dspace.current.user");
    String navbarNetid = null;
    if (user != null) {
        navbarNetid = user.getNetid();
    }

    // Is the logged in user an admin
    Boolean isAdmin = JSPManager.getBooleanAttribute(request, "is.admin");

    // Get the current page, minus query string
    String currentPage = UIUtil.getOriginalURL(request);
    int c = currentPage.indexOf('?');
    if (c > -1) {
        currentPage = currentPage.substring(0, c);
    }

    //toplevel communities
    SortedMap<String, String> topCommunities = (SortedMap<String, String>) request.getAttribute("top.communities");
%>



<div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="<%= request.getContextPath() %>">
        <span class="glyphicon glyphicon-home"> </span>
        <%= siteName %>
    </a>
</div>
<nav class="collapse navbar-collapse bs-navbar-collapse">
    <ul class="nav navbar-nav">

        <li class='<%= (currentPage.endsWith("/about") ? "active" : "")%>' >
        <a href="<%= request.getContextPath() %>/about"> <fmt:message key="jsp.layout.navbar-default.about"/> </a>
        </li>

        <li>
            <a href="mailto:<%= contactEmail %>"> <fmt:message key="jsp.layout.navbar-default.contact"/> </a>
        </li>

        <li class="<%= ( currentPage.endsWith( "/help" ) ? "active" : "" ) %>">
            <dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") %>">
                <fmt:message key="jsp.layout.navbar-default.help"/>
            </dspace:popup>
        </li>
    </ul>

    <div class="nav navbar-nav navbar-right">
        <ul class="nav navbar-nav navbar-right">
            <!-- SEARCH -->
            <li>
                <a href="<%= request.getContextPath() %>/simple-search">
                    <span class="glyphicon glyphicon-search"></span> Search </a>
            </li>

            <!-- BROWSE -->
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Explore <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%= request.getContextPath() %>/community-list"><fmt:message
                            key="jsp.layout.navbar-default.communities-collections"/></a></li>
                    <% if (topCommunities != null && topCommunities.size() > 0) { %>
                    <li class="divider"></li>
                    <%-- Insert the list of top level communities here --%>
                    <%
                        for (Map.Entry<String, String> entry : topCommunities.entrySet()) {
                            String handle = entry.getValue();
                            String name = entry.getKey();
                    %>
                    <li><a href="<%= request.getContextPath() %>/handle/<%= handle %>">
                        <%= name %></a></li>
                    <%
                        }
                    %>
                    <%-- End of dynamic community list --%>
                    <%
                        }
                    %>
                    </ul>
            </li>

            <!-- LOGIN or USER-SPECIFIC-MENU -->
            <li class="dropdown">
                <%
                    if (user != null) {
                %>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span
                        class="glyphicon glyphicon-user"></span> <fmt:message key="jsp.layout.navbar-default.loggedin">
                    <fmt:param><%= StringUtils.abbreviate(navbarNetid, 20) %>
                    </fmt:param>
                </fmt:message> <b class="caret"></b></a>
                <% } %>
                <ul class="dropdown-menu">
                    <li><a href="<%= request.getContextPath() %>/mydspace"><fmt:message
                            key="jsp.layout.navbar-default.users"/></a></li>
                    <%
                        if (isAdmin) {
                    %>
                    <li class="divider"></li>
                    <li><a href="<%= request.getContextPath() %>/dspace-admin"><fmt:message key="jsp.administer"/></a>
                    </li>
                    <%
                        }
                        if (user != null) {
                    %>
                    <li><a href="<%= request.getContextPath() %>/logout"><span
                            class="glyphicon glyphicon-log-out"></span> <fmt:message
                            key="jsp.layout.navbar-default.logout"/></a></li>
                    <% } %>

                </ul>
            </li>


        </ul>
    </div>


</nav>

