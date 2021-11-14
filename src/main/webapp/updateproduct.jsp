<%-- 
    Document   : updateproduct
    Created on : Nov 26, 2020, 6:56:37 PM
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


<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>update-product</title>
    </head>
    <body>
        <%@include file="components/common_css_js.jsp" %>
        <%@include file="components/navbar.jsp" %>

        <%
           if(request.getParameter("id")!=null){
            int id=Integer.parseInt(request.getParameter("id"));
            SessionFactory sf=FactoryProvider.getFactory();
            Session ss=sf.openSession();
            Product prt=(Product)ss.get(Product.class,id);
              if(prt!=null){
                
        %>
        
        <div class="container mt-4">
            
            <div class="row-mt4">
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center text-muted text-uppercase mb-4">Update Product Details</h3>
                        <form action="UpdateProduct" method="post" >
                            <input type="hidden" name="id" value="<%=prt.getpId()%>">
                            <div class="form-group">
                                <input type="text" class="form-control" value="<%=prt.getpName()%>" name="pName" placeholder="Enter Product Name" required />
                            </div>
                            <div class="form-group">
                                <textarea style="height: 100px" class="form-control"  placeholder="Enter Product Description" name="pDesc"><%=prt.getpDesc()%></textarea>
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" value="<%=prt.getpPrice()%>" name="pPrice" placeholder="Enter Product Price" required />
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" value="<%=prt.getpDiscount()%>" name="pDiscount" placeholder="Enter Product Discount" required />
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" value="<%=prt.getpQuantity()%>" name="pQuantity" placeholder="Enter Product Quantity" required />
                            </div>
                              
                            
<!--                            <div class="form-group">
                                <label for="pPhoto">Select Picture of Product </label>
                                <input type="file" id="pPhoto" name="pPhoto" />
                            </div>-->


                            <div class="text-center">
                                <button type="submit" class="btn btn-success">Update Product</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>    
                        </form>
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
