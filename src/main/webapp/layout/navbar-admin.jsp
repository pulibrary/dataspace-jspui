<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Navigation bar for admin pages
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%@ page import="org.dspace.browse.BrowseInfo" %>
<%@ page import="org.dspace.sort.SortOption" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.eperson.EPerson" %>
<%@page import="org.apache.commons.lang.StringUtils" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<ul class="nav navbar-nav navbar-admin">
    <li><a href="<%= request.getContextPath() %>/mydspace"><fmt:message
                    key="jsp.layout.navbar-default.users"/></a></li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="jsp.layout.navbar-admin.contents"/>
            <b class="caret"></b></a>
        <ul class="dropdown-menu">
            <li><a href="<%= request.getContextPath() %>/tools/edit-communities"><fmt:message
                    key="jsp.layout.navbar-admin.communities-collections"/></a></li>
            <li class="divider"></li>
            <li><a href="<%= request.getContextPath() %>/tools/edit-item"><fmt:message
                    key="jsp.layout.navbar-admin.items"/></a></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/workflow"><fmt:message
                    key="jsp.layout.navbar-admin.workflow"/></a></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/supervise"><fmt:message
                    key="jsp.layout.navbar-admin.supervisors"/></a></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/curate"><fmt:message
                    key="jsp.layout.navbar-admin.curate"/></a></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/withdrawn"><fmt:message
                    key="jsp.layout.navbar-admin.withdrawn"/></a></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/privateitems"><fmt:message
                    key="jsp.layout.navbar-admin.privateitems"/></a></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/metadataimport"><fmt:message
                    key="jsp.layout.navbar-admin.metadataimport"/></a></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/batchimport"><fmt:message
                    key="jsp.layout.navbar-admin.batchimport"/></a></li>
        </ul>
    </li>

    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message
                key="jsp.layout.navbar-admin.accesscontrol"/> <b class="caret"></b></a>
        <ul class="dropdown-menu">
            <li><a href="<%= request.getContextPath() %>/dspace-admin/edit-epeople"><fmt:message
                    key="jsp.layout.navbar-admin.epeople"/></a></li>
            <li><a href="<%= request.getContextPath() %>/tools/group-edit"><fmt:message
                    key="jsp.layout.navbar-admin.groups"/></a></li>
            <li><a href="<%= request.getContextPath() %>/tools/authorize"><fmt:message
                    key="jsp.layout.navbar-admin.authorization"/></a></li>
        </ul>
    </li>
    <li><a href="<%= request.getContextPath() %>/statistics"><fmt:message key="jsp.layout.navbar-admin.statistics"/></a>
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="jsp.layout.navbar-admin.settings"/>
            <b class="caret"></b></a>
        <ul class="dropdown-menu">
            <li><a href="<%= request.getContextPath() %>/dspace-admin/metadata-schema-registry"><fmt:message
                    key="jsp.layout.navbar-admin.metadataregistry"/></a></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/format-registry"><fmt:message
                    key="jsp.layout.navbar-admin.formatregistry"/></a></li>
            <li class="divider"></li>
            <li class="divider"></li>
            <li><a href="<%= request.getContextPath() %>/dspace-admin/license-edit"><fmt:message
                    key="jsp.layout.navbar-admin.editlicense"/></a></li>
        </ul>
    </li>

    <li> 
            <dspace:popup page='<%= LocaleSupport.getLocalizedMessage(pageContext, "help.site-admin") %>'>
                <fmt:message key="jsp.layout.navbar-default.help"/>
            </dspace:popup>
    </li>
</ul>


