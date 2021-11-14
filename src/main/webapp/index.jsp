<%-- 
    Document   : index
    Created on : Nov 21, 2020, 5:44:39 PM
    Author     : HP
--%>
<%@page import="com.learn.mycart.entities.User"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Cart - Home</title>



    </head>
    <body>
        <%@include file="components/common_css_js.jsp" %>


        



        <!--navbar-->
        <!--start-->



        
        <%
            User user1 = (User) session.getAttribute("current-user");
        %>




        <nav class="navbar navbar-expand-lg navbar-dark custom-bg">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">MyCart</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
                        </li>

                         <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Categories
                    </a>
                    
                    
                    <%                

                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getCategories();
                %>
                    
                    
                    
                    
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All Products</a>
                        <%
                            for (Category category : clist) {
                        %>
                        <a href="index.jsp?category=<%=category.getCategoryId()%>" class="list-group-item list-group-item-action"><%=category.getCategoryTittle()%></a>

                        <%
                            }

                        %>
                    </div>
                    
                    
                    
                    

                </li>
                    </ul>
                    <form action="searchproduct.jsp" method="get" class="form-inline my-2 my-lg-0">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="search">
                        <button style="border: none;"  class="btn btn-outline-success custom-bg my-2 my-sm-0 text-white" name="submit_search" type="submit">Search</button>
                    </form>

                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="#!" data-toggle="modal" data-target="#cart"><i class="fa fa-cart-plus " style="font-size: 20px;"></i><span class="ml-1 cart-items">( 0 )</span></a>

                        </li>

                        <%
                            if (user1 == null) {
                        %>
                        <li class="nav-item active">
                            <a class="nav-link" href="login.jsp">Login</a>

                        </li>
                        <li class="nav-item active">

                            <a class="nav-link" href="register.jsp">Register</a>
                        </li>
                        <%
                        } else {
                        %>
                        <li class="nav-item active">
                            <a class="nav-link" href="<%= user1.getUserType().equals("admin") ? "admin.jsp" : "normal.jsp"%>"><%=user1.getUserName()%></a>

                        </li>
                        <li class="nav-item active">

                            <a class="nav-link" href="LogoutServlet">Logout</a>
                        </li>

                        <%
                            }
                        %>

                    </ul>
                </div>
            </div>
        </nav>











        <!--End-->
        
        
        
        
        
        
        


        <div class="container-fluid">

            <div class="row mt-3 mx-2">
                <%                    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> list = null;
                    String cat = request.getParameter("category");
                    // out.print(cat);

                    if (cat == null) {
                        list = dao.getAllProduct();
                    } else if (cat.trim().equals("all")) {
                        list = dao.getAllProduct();
                    } else {

                        int cid = Integer.parseInt(cat.trim());
                        list = dao.getAllProductById(cid);
                    }

                    
                %>

                <!--show categories-->
                <div class="col-md-2">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All Products</a>
                        <%
                            for (Category category : clist) {
                        %>
                        <a href="index.jsp?category=<%=category.getCategoryId()%>" class="list-group-item list-group-item-action"><%=category.getCategoryTittle()%></a>

                        <%
                            }

                        %>
                    </div>
                </div>

















                <!--show product-->
                <div class="col-md-10">



                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="card-columns">

                                <%          for (Product product : list) {


                                %>
                                <div class="card product-card">

                                    <div class="container text-center">
                                        <img src="img/products/<%=product.getpPhoto()%>" style="max-height: 200px; max-width: 100%; width:auto" class="card-img-top mt-2" alt="default,jpg">
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-tittle"><%= product.getpName()%></h5>
                                        <p class="card-text"><%=Helper.get10Words(product.getpDesc())%></p>

                                    </div> 

                                    <div class="card-footer text-center">
                                        <button class="btn custom-bg text-white" onclick="add_to_cart(<%=product.getpId()%>, '<%=product.getpName()%>',<%=product.getPriceAfterApplyingDiscount()%>)" >Add to Cart</button>
                                        <button class="btn btn-outline-primary ">&#x20B9; <%=product.getPriceAfterApplyingDiscount()%>/- <span class="text-secondary  discount-label">&#x20B9; <%=product.getpPrice()%>, <%=product.getpDiscount()%>% off</span></button>
                                    </div>
                                </div>

                                <%}
                                    if (list.size() == 0) {
                                        out.println("<h3 class='text-muted'>No Item in This Category</h3>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>






                </div>



            </div>

        </div>

        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
