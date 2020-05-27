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

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="java.util.Locale" %>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.core.NewsManager" %>
<%@ page import="java.util.SortedMap" %>
<%@ page import="java.util.Map" %>


<%
    SortedMap<String, String> communities = (SortedMap<String, String>) request.getAttribute("top.communities");
    Locale sessionLocale = UIUtil.getSessionLocale(request);
    Config.set(request.getSession(), Config.FMT_LOCALE, sessionLocale);
    String topNews = NewsManager.readNewsFile(LocaleSupport.getLocalizedMessage(pageContext, "news-top.html"));
%>

<dspace:layout titlekey="jsp.home.title">

    <div class="col-md-12">
        <%= topNews %>
    </div>


    <div class="col-md-12">
        <h3><fmt:message key="jsp.home.com1"/></h3>
    </div>


    <% if (communities != null ) { %>
    <!-- list top level communities -->
    <div class="col-md-6">
        <div class="list-group">
    <%
        int ncomm = communities.size();
        int splitAti = ncomm / 2;
        int i = 0;
        for (Map.Entry<String, String> entry : communities.entrySet()) {
            if (i == splitAti) {
    %>
        </div>
    </div>
    <div class="col-md-6">
        <div class="list-group">
     <%
         }
     %>
            <div class="list-group-item">
                <h4 class="list-group-item-heading"><a
                        href="<%= request.getContextPath() %>/handle/<%= entry.getValue() %>"><%= entry.getKey() %>
                </a>
                </h4>
            </div>
    <%
            i = i + 1;
        }
    %>
        </div>
    </div>
    <% } else { %>
    <div class='debug col-md-12'> top.communities attribute is null </div>
    <% } %>

</dspace:layout>
