<%-- 
    Document   : checkout
    Created on : Nov 25, 2020, 5:43:04 PM
    Author     : HP
--%>

<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not Logged in ! Login First to Access Checkout Page");
        response.sendRedirect("login.jsp");
        return;
    }
%>

















<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container">
            <div class="row mt-5">
                <div class="col-md-6">
                    <!--Cart Item-->
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-center mb-5 text-muted">Your Selected Items</h3>

                            <div class="cart-body">

                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-md-6">
                    <!--User Form-->
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-center mb-5 text-muted">Your Details for Order</h3>
                            <form>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input value="<%= user.getUserEmail()%>" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>

                                <div class="form-group">
                                    <label for="name">Your Name</label>
                                    <input value="<%= user.getUserName()%>" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">

                                </div>
                                <div class="form-group">
                                    <label for="name">Your Contact</label>
                                    <input value="<%= user.getUserPhone()%>" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter contact number">

                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlTextarea1">Your Shipping Address</label>
                                    <textarea  class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="Enter your Shipping Address"><%= user.getUserAddress()%></textarea>
                                </div>
                                <div class="container text-center">
                                    <button class="btn btn-outline-success">Order Now</button>
                                    <button class="btn btn-outline-primary" ><a href="index.jsp">Continue Shopping</a></button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>  
        </div>


        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
