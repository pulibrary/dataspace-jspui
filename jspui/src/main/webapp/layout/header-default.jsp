<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - HTML header for main home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List"%>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.app.util.Util" %>
<%@ page import="org.dspace.content.Collection" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.content.DSpaceObject" %>
<%@ page import="org.dspace.app.webui.util.JSPManager" %>
<%@ page import="org.dspace.app.webui.helper.JSPParameter" %>

<%
    String environment = ConfigurationManager.getProperty("dspace.environment");
    
    JSPParameter params = new JSPParameter(request);
    
    String title = (String) request.getAttribute("dspace.layout.title");
    String loggedin = request.getAttribute("dspace.current.user") == null ? "" : "loggedin";
    // Is the logged in user an admin
    boolean isAdmin = JSPManager.getBooleanAttribute(request, "is.admin");

    String navbar = (String) request.getAttribute("dspace.layout.navbar");
    if (navbar.equals("off")) {
        navbar = "/layout/navbar-minimal.jsp" ;
        isAdmin = false;  // don't show admin navbar menu
    }

    String siteName = ConfigurationManager.getProperty("dspace.name");
    String feedRef = (String)request.getAttribute("dspace.layout.feedref");
    boolean osLink = ConfigurationManager.getBooleanProperty("websvc.opensearch.autolink");
    String osCtx = ConfigurationManager.getProperty("websvc.opensearch.svccontext");
    String osName = ConfigurationManager.getProperty("websvc.opensearch.shortname");
    List parts = (List)request.getAttribute("dspace.layout.linkparts");
    String extraHeadData = (String)request.getAttribute("dspace.layout.head");
    String extraHeadDataLast = (String)request.getAttribute("dspace.layout.head.last");
    String dsVersion = Util.getSourceVersion();
    String generator = dsVersion == null ? "DSpace" : "DSpace "+dsVersion;
    String analyticsKey = ConfigurationManager.getProperty("jspui.google.analytics.key");
    // use handles of parents as classes on main div
    // Grab parents from the URL - these should have been picked up
    // by the HandleServlet
    String main_classes = "";
    {

        if (null != request.getAttribute("dspaceObject.parents.handles")) {
            List<String> handles = (List<String>) request.getAttribute("dspaceObject.parents.handles");

            for (String hdl : handles) {
                main_classes = main_classes + " hdl-" + hdl.replace('/', '-');
            }
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title><%= siteName %>: <%= title %></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="Generator" content="<%= generator %>" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="IE=edge" http-equiv="X-UA-Compatible">

        <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon"/>

        <!-- Princeton University Customization to add rendering of mathematical formulae by MathJAX -->
        <script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-MML-AM_CHTML'></script>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/dspace-theme.css" type="text/css" />
<%
    if (!"NONE".equals(feedRef))
    {
        for (int i = 0; i < parts.size(); i+= 3)
        {
%>
        <link rel="alternate" type="application/<%= (String)parts.get(i) %>" title="<%= (String)parts.get(i+1) %>" href="<%= request.getContextPath() %>/feed/<%= (String)parts.get(i+2) %>/<%= feedRef %>"/>
<%
        }
    }
    
    if (osLink)
    {
%>
        <link rel="search" type="application/opensearchdescription+xml" href="<%= request.getContextPath() %>/<%= osCtx %>description.xml" title="<%= osName %>"/>
<%
    }

    if (extraHeadData != null)
        { %>
<%= extraHeadData %>
<%
        }
%>

	<script type='text/javascript' src='<%= request.getContextPath() %>/static/js/holder.js'></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/utils.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/choice-support.js"> </script>
    
    <%--Gooogle Analytics recording.--%>
    <%
        if (analyticsKey != null && analyticsKey.length() > 0) {
            out.println("<!-- google analytics javascript snippet for '" + analyticsKey + "' -->");
            if (null != params.currentUser) {
                out.println("<!-- not tracking analytics when logged in  -->");
            } else {
                if (params.isTestInstance()) {
                    out.println("<!-- tracking analytics in production only  -->");
                } else {
    %>
    <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '<%= analyticsKey %>']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script');
            ga.type = 'text/javascript';
            ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(ga, s);
        })();
    </script>
    <%
                }
            }
        }
    %>
    
    <%
        if (extraHeadDataLast != null) {
            out.println(extraHeadDataLast);
        }
    %>
    

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="<%= request.getContextPath() %>/static/js/html5shiv.js"></script>
  <script src="<%= request.getContextPath() %>/static/js/respond.min.js"></script>
<![endif]-->
    </head>

    <%-- HACK: leftmargin, topmargin: for non-CSS compliant Microsoft IE browser --%>
    <%-- HACK: marginwidth, marginheight: for non-CSS compliant Netscape browser --%>
    <body class='undernavigation <%= loggedin%> <%= environment %>'>
    <a class="sr-only" href="#content">Skip navigation</a>
    <header class="navbar navbar-dspace navbar-fixed-top">
        <div class="container">
            <jsp:include page="<%= navbar %>"/>
        </div>
    </header>

<% if (isAdmin) { %>
        <div class="navbar">
        <div class="container">
            <jsp:include page="/layout/navbar-admin.jsp"/>
        </div>
        </div>
<% } %>

<main id="content" class="MAIN <%= main_classes%>">

<%-- Location bar --%>
<div class="container">
    <jsp:include page="/layout/location-bar.jsp" />
</div>


        <%-- Page contents --%>
<div class="container">
<% if (request.getAttribute("dspace.layout.sidebar") != null) { %>
	<div class="row">
		<div class="col-md-9">
<% } %>		
