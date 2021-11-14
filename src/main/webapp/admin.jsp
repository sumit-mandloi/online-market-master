<%@page import="com.learn.mycart.dao.UserDao"%>
<%@page import="java.util.ListIterator"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.query.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.User"%>
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





<%  CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cDao.getCategories();

//getting count  
    Map<String, Long> m = Helper.getCounts(FactoryProvider.getFactory());
%>








<%-- 
    Document   : admin
    Created on : Nov 22, 2020, 2:48:46 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
        <style>
           .update, .delete{
                border-radius: 4px;
                padding: 5px;

            }

            .update,.delete{
                border: thin solid;
            }

        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp"%>
            </div>
            <!--first row-->
            <div class="row mt-4">
                <!--first box-->
                <div class="col-md-4"> 
                    <div class="card" data-toggle="modal" data-target="#showuser">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fuild rounded-circle" src="img/profile.png" alt="user_icon">
                            </div>
                            <h1><%=m.get("userCount")%></h1>
                            <h1><a class="text-uppercase text-muted text-white" >User</a></h1>
                        </div>
                    </div>
                </div>
                <!--second box-->
                <div class="col-md-4">
                    <div class="card" data-toggle="modal" data-target="#showcategories">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fuild rounded-circle" src="img/list.png" alt="user_icon">
                            </div>   
                            <h1><%=list.size()%></h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>
                </div>
                <!--third box-->
                <div class="col-md-4">
                    <div class="card" data-toggle="modal" data-target="#showproduct">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fuild rounded-circle" src="img/package.png" alt="user_icon">
                            </div>
                            <h1><%=m.get("productCount")%></h1>
                            <h1 ><a class="text-uppercase text-muted text-white" >Product</a></h1>
                        </div>
                    </div>
                </div>
            </div>





            <!--second row-->
            <div class="row mt-4">
                <!--first col-->
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-model">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fuild rounded-circle" src="img/box.png" alt="user_icon">
                            </div>
                            <p class="mt-2">Click here to add new Category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
                </div>
                <!--second col-->
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-model">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fuild rounded-circle" src="img/plus.png" alt="user_icon">
                            </div>
                            <p>Click here to add new Product</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                        </div>
                    </div>
                </div>
            </div> 
        </div>

        <!----------------------------------------------------------------------------------------------------------------------------------------------->
        <!--Add Category Model-->


        <div class="modal fade" id="add-category-model" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog model-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" class="form-control" name="categoryTittle" placeholder="Enter Category Tittle" required />
                            </div>
                            <div class="form-group">
                                <textarea style="height: 300px" class="form-control" placeholder="Enter Category Description" name="categoryDescription"></textarea>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>    
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <!--End Category Model-->

        <!---------------------------------------------------------------------------------------------------------------------------------------------->

        <!--Add Product Model-->

        <div class="modal fade" id="add-product-model" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog model-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addproduct">
                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter Product Name" required />
                            </div>
                            <div class="form-group">
                                <textarea style="height: 100px" class="form-control" placeholder="Enter Product Description" name="pDesc"></textarea>
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter Product Price" required />
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter Product Discount" required />
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter Product Quantity" required />
                            </div>





                            <div class="form-group">
                                <select name="categoryId" class="form-control" id="">

                                    <%        for (Category c : list) {
                                    %>

                                    <option value="<%=c.getCategoryId()%>"><%=c.getCategoryTittle()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="pPhoto">Select Picture of Product </label>
                                <input type="file" id="pPhoto" name="pPhoto" required/>
                            </div>


                            <div class="text-center">
                                <button type="submit" class="btn btn-success">Add Product</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>    
                        </form>
                    </div>

                </div>
            </div>
        </div>



        <!--End Product Model-->











        <!--show Categories-->


        <!--start-->





        <!-- Modal -->
        <div class="modal fade" id="showcategories" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title text-uppercase " id="exampleModalLabel">Categories</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="list-group mt-4">

                            <%
                                for (Category category : list) {
                            %>
                            <a  class="list-group-item list-group-item-action"><%=category.getCategoryTittle()%></a>

                            <%
                                }

                            %>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary text-center" data-dismiss="modal">Close</button>

                    </div>
                </div>
            </div>
        </div>


        <!--End-->




        <!-- show product model-->
        <!--start-->




        <div class="modal fade" tabindex="-1" id="showproduct" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header custom-bg  text-white">
                        <h5 class="modal-title text-uppercase" id="exampleModal">Product</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                    </div>
                    <div class="modal-body">

                        <div class="row mt-4">
                            <div class="col-md-12">
                                <div class="card-columns">


                                    <%   ProductDao daop = new ProductDao(FactoryProvider.getFactory());
                                        List<Product> listp = null;
                                        listp = daop.getAllProduct();
                                        for (Product productss : listp) {
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
                                            <button class="btn btn-outline-primary mt-2">&#x20B9; <%=productss.getPriceAfterApplyingDiscount()%>/- <span class="text-secondary  discount-label">&#x20B9; <%=productss.getpPrice()%>, <%=productss.getpDiscount()%>% off</span></button>
                                        </div>
                                    </div>

                                    <%}

                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>










        <!--end-->




        <!--show user-->


        <!--    <div class="modal-header custom-bg text-white">
                                <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>-->
        <!--start-->





        <div class="modal fade" tabindex="-1" id="showuser">
            <div class="modal-dialog modal-lg">
                <div class="modal-content  ">
                    <div class="modal-header text-white custom-bg">
                        <h5 class="modal-title text-uppercase"  id="exampleModalLabel">User</h5>

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>

                    </div>
                    <div class="modal-body">

                        <div class="row-mt-4">
                            <div class="col-md-12">



                                <table class=" table table-striped"  >
                                    <thead>
                                        <tr>
                                            <th >ID</th>
                                            <th>Name</th>
                                            <th>Contact</th>
                                            <th>Address</th>
                                            <th>Password</th>
                                            <th>Email</th>



                                        </tr>
                                    </thead> 
                                    <%                    UserDao daou = new UserDao(FactoryProvider.getFactory());
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
                                            <td>  <%= useru.getUserPassword()%></td>
                                            <td>  <%= useru.getUserEmail()%></td>




                                        </tr>
                                    </div>
                                    <%
                                        }
                                    %>

                                </table>


                            </div>


                        </div>
                    </div>
                    <div class="modal-footer text-white">
                        <a class=" custom-bg  delete  text-white" href="showuser.jsp">Edit</a>
                        <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Close</button>

                    </div>
                </div>
            </div>
        </div>














        <!--end-->









        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
