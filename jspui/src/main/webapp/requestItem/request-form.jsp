<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Sugest form JSP
  -
  - Attributes:
  -    requestItem.problem  - if present, report that all fields weren't filled out
  -    authenticated.email - email of authenticated user, if any
  -	   handle - URL of handle item
  --%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="org.dspace.app.webui.servlet.RequestItemServlet"%>

<%
	request.setCharacterEncoding("UTF-8");

    boolean problem = (request.getAttribute("requestItem.problem") != null);

    String email = (String) request.getAttribute("email");
    if (email == null)
        email = "";

    String userName = (String) request.getAttribute("reqname");
    if (userName == null)
        userName = "";

    String handle = (String) request.getAttribute("handle");
    if (handle == null )
        handle = "";
	
    String title = (String) request.getAttribute("title");
    if (title == null)
        title = "";
		
    String coment = (String) request.getAttribute("coment");
    if (coment == null)
        coment = "";

    String bitstream_id = (String) request.getAttribute("bitstream-id");

%>

<dspace:layout locbar="off" navbar="default" titlekey="jsp.request.item.request-form.title" >

<h2>Request Documents </h2>

    <p>
        Please provide your name, email address and a brief message regarding the item that you are requesting.
        The collection administrator will respond to your request.
    </p>

<p>

<%
    	if (problem)
    	{
%>
        <p class="alert alert-warning"><fmt:message key="jsp.request.item.request-form.problem"/></p>
<%
    	}
%>
    <form name="form1" class="form-horizontal" action="<%= request.getContextPath() %>/request-item" method="post">
		<div class="form-group">
         <label for="reqname" class="control-label col-md-2">Your Name:</label>
         <div class="col-md-10">
         	<input class="form-control" type="text" name="reqname" size="50" value="<%= userName %>">
         </div>
        </div>
        <div class="form-group">
         <label for="email" class="control-label col-md-2">Your Email:</label>
         <div class="col-md-10">
			<input type="text" class="form-control" name="email" size="50" value="<%= email %>">
         </div>
        </div>
        <div class="form-group">
         <label for="coment" class="control-label col-md-2"><fmt:message key="jsp.request.item.request-form.coment"/></label>
		 <div class="col-md-10">
	         <textarea class="form-control" name="coment" rows="6" cols="46" wrap=soft><%= coment %></textarea>
    	 </div>
        </div>
        
         <input type="hidden" name="handle" value='<%= handle %>' />
         <input type="hidden" name="bitstream-id" value='<%= bitstream_id %>' />
         <input type="hidden" name="step" value="<%=RequestItemServlet.ENTER_FORM_PAGE %>" />
        <div class="btn btn-group col-md-4 pull-right row">
         <a class="btn btn-default col-md-6" href="<%=request.getContextPath()%>/handle/<%=handle %>"><fmt:message key="jsp.request.item.request-form.cancel" /></a>
         <button type="submit" name="submit" class="btn btn-primary col-md-6" value="true"><fmt:message key="jsp.request.item.request-form.go"/></button>
        </div> 
    </form>
</p>

</dspace:layout>