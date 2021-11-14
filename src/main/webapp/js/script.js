

function add_to_cart(pid, pname, price) {


    let cart = localStorage.getItem("cart");
    if (cart == null) {

        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        //console.log("Product is Added First time")
        showToast("Item is Added to Cart");
    } else {
        let pcart = JSON.parse(cart);
        let oldProduct = pcart.find((item) => item.productId == pid)
        if (oldProduct) {

            oldProduct.ProductQuantity = oldProduct.ProductQuantity + 1
            pcart.map((item) => {
                if (item.productId == oldProduct.productId) {
                    item.productQuantity = oldProduct.ProductQuantity;
                }
            })
            localStorage.setItem("cart", JSON.stringify(pcart));
           // console.log("Product Quantity is increased")
            showToast(oldProduct.productName+"Quantity is Increased");
        } else {
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
            pcart.push(product)
            localStorage.setItem("cart", JSON.stringify(pcart));
           // console.log("Product is Added")
           showToast("Product is Added to Cart");
        }
    }
    updateCart();
}



function updateCart() {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart == null || cart.length == 0)
    {
        console.log("cart is empty !!")
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart does not have any Item</h3>")
        $(".checkout-btn").attr('disabled',true);
    } else {
        console.log(cart);
        $(".cart-items").html(`( ${cart.length} )`);
        let table = `
           <table class='table'>
           <thead class='thread-light'>
            <tr>
            <th>Item Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
            <th>Action</th>

           </tr>
   
          </thead>
  
    `;
        let totalPrice = 0;
        cart.map((item) => {


            table += `
           <tr>
            <td>${ item.productName } </td>
            <td>${ item.productPrice } </td>
            <td>${ item.productQuantity } </td>
            <td>${ item.productQuantity * item.productPrice } </td>
            <td><button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Remove</button>
            </tr>
             `
            totalPrice += item.productPrice * item.productQuantity;

        })


        table = table + `
         <tr><td colspan='5' class='text-right font-weight-bold m-5'>Total Price : ${totalPrice}</td></tr>
          </table>`

        $(".cart-body").html(table)
        $(".checkout-btn").attr('disabled',false);



    }
}

function deleteItemFromCart(pid) {
    let cart = JSON.parse(localStorage.getItem('cart'));
    let newcart = cart.filter((item) => item.productId != pid)
    localStorage.setItem('cart', JSON.stringify(newcart))
    updateCart();
    showToast("Item is Removed from Cart")
}

$(document).ready(function () {
    updateCart()
})    




function showToast(content) {
    $("#toast").addClass("display");
    $("#toast").html(content);


    setTimeout(() => {
        $("#toast").removeClass("display");
    }, 2000);
}



function goToCheckout(){
    window.location="checkout.jsp"
}