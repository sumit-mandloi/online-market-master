<%-- 
    Document   : showuser
    Created on : Nov 26, 2020, 10:12:42 PM
    Author     : HP
--%>


<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not Logged in ! Login First");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not Admin ! Do not Accesss this Page");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@page import="com.learn.mycart.entities.User"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.UserDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>show-user</title>
        <style>
            .delete{
                border-radius: 4px;
                padding: 5px;

            }
            
            .delete{
                border: thin solid;
            }

        </style>
    </head>
    <body>
        <%@include file="components/common_css_js.jsp" %>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid p-2 m-2">
            <%@include file="components/message.jsp"%>
            <div class="card">
                
                <h3 class="text-center text-muted text-uppercase mt-4">All Registered User</h3>
                <div class="card-body">
                      <table class=" table table-striped"  >
                <thead>
                    <tr>
                        <th >ID</th>
                        <th>Name</th>
                        <th>Contact</th>
                        <th>Address</th>
                        <th>Email</th>


                        <th>Password</th>
                    </tr>
                </thead> 
                <%
                    UserDao daou = new UserDao(FactoryProvider.getFactory());
                    List<User> listu = null;
                    listu = daou.getAllUser();
                    for (User useru : listu) {

                %>
                <div>
                    <tr>
                        <td>  <%= useru.getUserId()%></td>
                        <td>  <%= useru.getUserName()%></td>
                        <td>  <%= useru.getUserPhone()%></td>
                        <td>  <%= useru.getUserAddress()%></td>
                        <td>  <%= useru.getUserEmail()%></td>

                        <td>  <%= useru.getUserPassword()%></td>

                        <td>   <a class="delete custom-bg text-white" href="DeleteUser?id=<%= useru.getUserId()%>">Delete</a></td>
                    </tr>
                </div>
                <%
                    }
                %>

            </table>
                </div>
            </div>
        </div>
    </body>
</html>
