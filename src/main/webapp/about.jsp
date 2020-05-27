<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Home page JSP
  -
  - Attributes:
  -    communities - Community[] all communities in DSpace
  -    recent.submissions - RecetSubmissions
  --%>

<%@page import="org.dspace.core.Utils" %>
<%@page import="org.dspace.content.Bitstream" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="org.dspace.core.NewsManager" %>
<%@ page import="org.dspace.app.webui.components.TopCommunitiesProcessor" %>

<%
    String about = NewsManager.readNewsFile("about.html");
    TopCommunitiesProcessor.process(request);

%>

<dspace:layout locbar="nolink" titlekey="jsp.home.title">

    <div class="container row">
        <%= about %>
    </div>

</dspace:layout>
