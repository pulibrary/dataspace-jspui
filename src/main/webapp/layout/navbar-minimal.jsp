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

<%@ page import="java.util.Locale" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.core.I18nUtil" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.eperson.EPerson" %>
<%
    String siteName = ConfigurationManager.getProperty("dspace.name");
    String contactEmail = ConfigurationManager.getProperty("feedback.recipient");

    // Is anyone logged in?
    EPerson user = (EPerson) request.getAttribute("dspace.current.user");

    // Is the logged in user an admin
    Boolean admin = (Boolean) request.getAttribute("is.admin");
    boolean isAdmin = (admin == null ? false : admin.booleanValue());

    // Get the current page, minus query string
    String currentPage = UIUtil.getOriginalURL(request);
    int c = currentPage.indexOf('?');
    if (c > -1) {
        currentPage = currentPage.substring(0, c);
    }

    String navbarNetid = null;

    if (user != null) {
        navbarNetid = user.getNetid();
    }
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

<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
    <div class="row default">

    <div>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <%
                    if (user != null) {
                %>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span
                        class="glyphicon glyphicon-user"></span> <fmt:message key="jsp.layout.navbar-default.loggedin">
                    <fmt:param><%= StringUtils.abbreviate(navbarNetid, 20) %>
                    </fmt:param>
                </fmt:message> <b class="caret"></b></a>
                <%
                } else {
                %>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span
                        class="glyphicon glyphicon-user"></span> <fmt:message key="jsp.layout.navbar-default.sign"/> <b
                        class="caret"></b></a>
                <% } %>
                <ul class="dropdown-menu">
                    <li><a href="<%= request.getContextPath() %>/mydspace"><fmt:message
                            key="jsp.layout.navbar-default.users"/></a></li>
                    <% if (user != null) { %>
                    <li><a href="<%= request.getContextPath() %>/profile"><fmt:message
                            key="jsp.layout.navbar-default.edit"/></a></li>
                    <% } %>

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


    </div>
</nav>


