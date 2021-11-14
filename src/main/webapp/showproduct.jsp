<%-- 
    Document   : showproduct
    Created on : Nov 26, 2020, 6:20:23 PM
    Author     : HP
--%>


<%
    User user5 = (User) session.getAttribute("current-user");
    if (user5 == null) {
        session.setAttribute("message", "You are not Logged in ! Login First");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user5.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not Admin ! Do not Accesss this Page");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>



<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%

    ProductDao daop = new ProductDao(FactoryProvider.getFactory());
    List<Product> listp = null;
    listp = daop.getAllProduct();
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>all-product</title>
        <style>
            .update,.delete{
                border-radius: 4px;
                padding: 5px;

            }
            .update{
                border: thin solid;
            }
            .delete{
                border: thin solid;
            }

        </style>
    </head>
    <body>
        <%@include file="components/common_css_js.jsp" %>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
            <%@include file="components/message.jsp"%>
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="card-columns">

                        <%       for (Product productss : listp) {
                        %>
                        <div class="card product-card">

                            <div class="container text-center">
                                <img src="img/products/<%=productss.getpPhoto()%>" style="max-height: 200px; max-width: 100%; width:auto" class="card-img-top mt-2" alt="default,jpg">
                            </div>
                            <div class="card-body">
                                <h5 class="card-tittle"><%= productss.getpName()%></h5>
                                <p class="card-text"><%=Helper.get10Words(productss.getpDesc())%></p>

                            </div> 

                            <div class="card-footer text-center">
                                 <a class="update text-white custom-bg" href="updateproduct.jsp?id=<%= productss.getpId()%>">Update</a>
                                 <a class="delete update text-white custom-bg" href="DeleteProducts?id=<%= productss.getpId()%>">Delete</a>
                                <button class="btn btn-outline-primary ">&#x20B9; <%=productss.getPriceAfterApplyingDiscount()%>/- <span class="text-secondary  discount-label">&#x20B9; <%=productss.getpPrice()%>, <%=productss.getpDiscount()%>% off</span></button>
                            </div>
                        </div>

                        <%}
                           
                        %>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
