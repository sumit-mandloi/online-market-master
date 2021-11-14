<%-- 
    Document   : updateuser
    Created on : Nov 27, 2020, 8:24:27 PM
    Author     : HP
--%>


<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="com.learn.mycart.entities.User"%>
<%
    User user3 = (User) session.getAttribute("current-user");
    if (user3 == null) {
        session.setAttribute("message", "You are not Logged in ! Login First");
        response.sendRedirect("login.jsp");
        return;
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>user-updateion</title>
    </head>
    <body>
        <%@include file="components/common_css_js.jsp" %>
         <%@include file="components/navbar.jsp" %>
     <%
           if(request.getParameter("id")!=null){
            int id=Integer.parseInt(request.getParameter("id"));
            SessionFactory sf=FactoryProvider.getFactory();
            Session ss=sf.openSession();
            User usr=(User)ss.get(User.class,id);
               if(usr!=null){
                
        %>
        
        
          <div class="container-fluid">
            <div class="row mt-5">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        
                        <div class="card-body px-5">
                            <div class="container text-center">
                                <img src="img/sign-up.png" style="max-width: 100px;" class="img-fuild">
                            </div>
                            <h3 class="text-center my-3">Update Profile</h3>
                            <form action="UpdateUser" method="post">
                                <input type="hidden" name="id" value="<%=usr.getUserId()%>">
                                <div class="form-group">
                                    <label for="name">User Name</label>
                                    <input name="user_name" value="<%=usr.getUserName()%>" type="text" class="form-control" id="name" placeholder="Enter here" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="email">User Email</label>
                                    <input name="user_email" value="<%=usr.getUserEmail()%>" type="email" class="form-control" id="email" placeholder="Enter here" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="password">User Password</label>
                                    <input name="user_password"value="<%=usr.getUserPassword()%>" type="password" class="form-control" id="password" placeholder="Enter here" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="phone">User Phone</label>
                                    <input name="user_phone" value="<%=usr.getUserPhone()%>" type="number" class="form-control" id="phone" placeholder="Enter here" aria-describedby="emailHelp">
                                </div>
                                `<div class="form-group">
                                    <label for="address">User Address</label>
                                    <textarea name="user_address" style="height:200px" class="form-control" placeholder="Enter your address"><%=usr.getUserAddress()%></textarea>
                                </div>
                                <div class="container text-center">
                                    <button class="btn btn-outline-success">Update</button>
                                    <button class="btn btn-outline-warning">Reset</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        
        
        
        
        <% }
    }else{
  out.println("Select any record Caused Id is Null");
}
%>
    </body>
</html>
