<%@page import="com.learn.mycart.entities.User"%>
<%
    User user2 = (User) session.getAttribute("current-user");
    if (user2 == null) {
        session.setAttribute("message", "You are not Logged in ! Login First");
        response.sendRedirect("login.jsp");
        return;
    }

%>


<%-- 
    Document   : normal
    Created on : Nov 22, 2020, 2:48:35 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User</title>
         <style>
            .update,.delete{
                border-radius: 4px;
                padding: 5px;

            }
            .update{
                border: thin solid green;
            }
            .delete{
                border: thin solid red;
            }

        </style>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class="card mt-4">
                <%@include file="components/message.jsp" %>
                <div class="card-body col d-flex justify-content-center">


                    <div class="card  col-md-4 border-0">
                        <div class="card-body">
                            <div class="container text-center">
                                <h4 class="text-center text-muted">Profile Picture</h4>
                                <img style="max-width: 125px;" class="img-fuild rounded-circle" src="img/profile.png" alt="user_icon">
                            </div>
                        </div>
                    </div>



                </div>
                <div class="card-body col d-flex justify-content-center">
                    <div class="card  col-md-8 border-0">



                        <table class=" table table-striped"  >

                            <thead>
                                <tr>
                                    <th >ID</th> 
                                </tr>
                            </thead>
                            <div>
                                <tr>
                                    <td><%=user2.getUserId()%></td>
                                </tr>
                            </div>

                            <thead>
                                <tr>
                                    <th >Name</th>
                                </tr>
                            </thead>
                            <div>
                                <tr>
                                    <td><%=user2.getUserName()%></td>
                                </tr>
                            </div>


                            <thead>
                                <tr>
                                    <th >Email</th>
                                </tr>
                            </thead>
                            <div>
                                <tr>
                                    <td><%=user2.getUserEmail()%></td>
                                </tr>
                            </div>




                            <thead>
                                <tr>
                                    <th >Password</th>
                                </tr>
                            </thead>
                            <div>
                                <tr>
                                    <td><%=user2.getUserPassword()%></td>
                                </tr>
                            </div>


                            <thead>
                                <tr>
                                    <th >Mobile Number</th>
                                </tr>
                            </thead>
                            <div>
                                <tr>
                                    <td><%=user2.getUserPhone()%></td>
                                </tr>
                            </div>


                            <thead>
                                <tr>
                                    <th >Address</th>
                                </tr>
                            </thead>
                            <div>
                                <tr>
                                    <td><%=user2.getUserAddress()%></td>
                                </tr>
                            </div>

                        </table>




                        <div class="card-footer">
                            <a class="update tex-white" href="updateuser.jsp?id=<%=user2.getUserId()%>">Update</a>
                            <a class="delete" href="DeleteUser?id=<%=user2.getUserId()%>">Delete</a>
                        </div>

                    </div>



                </div>
            </div>
        </div>
        </
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
