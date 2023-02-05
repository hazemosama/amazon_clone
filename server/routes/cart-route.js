const express = require("express");
const cartRouter = express.Router();
const authMiddleware = require("../middlewares/auth-middleware");
const Order = require("../models/order-model");
const Product = require("../models/product-model").Product;
const User = require("../models/user-model");

cartRouter.post("/add", authMiddleware, async (req, res) => {
  try {
    const id = req.body.product_id;
    const product = await Product.findById(id);
    if (product.quantity == 0) {
      return res.json({ message: "Product out of stock", data: user });
    }
    let user = await User.findById(req.user).populate("cart.product");
    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
      user = await user.save();
      return res.json({ message: "Successfully added to cart", data: user });
    } else {
      let productIndex;
      let productInCart = false;
      for (i in user.cart) {
        if (user.cart[i].product.quantity == 0) {
          user.cart.splice(i, 1);
        }
        if (user.cart[i].product._id.equals(product._id)) {
          productIndex = i;
          productInCart = true;
          break;
        }
      }
      if (productInCart) {
        if (
          user.cart[productIndex].quantity <
          user.cart[productIndex].product.quantity
        ) {
          user.cart[productIndex].quantity += 1;
          user = await user.save();
          res.json({ message: "Quantity increased", data: user });
        } else {
          user = await user.save();
          return res.json({ message: "Quantity not enough!", data: user });
        }
      } else {
        user.cart.push({ product, quantity: 1 });
        user = await user.save();
        return res.json({ message: "Successfully added to cart", data: user });
      }
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

cartRouter.delete("/decrease/:id", authMiddleware, async (req, res) => {
  try {
    const id = req.params.id;
    const product = await Product.findById(id);
    let user = await User.findById(req.user).populate("cart.product");
    let productInCart = false;
    let productIndex;
    let quantity;

    for (i in user.cart) {
      if (user.cart[i].product._id.equals(product._id)) {
        productInCart = true;
        productIndex = i;
        quantity = user.cart[i].quantity;
      }
    }
    if (productInCart) {
      if (quantity == 1) {
        user.cart.splice(productIndex, 1);
        user = await user.save();
        return res.json({ message: "Product removed from cart", data: user });
      } else {
        user.cart[productIndex].quantity = user.cart[productIndex].quantity - 1;
        user = await user.save();
        return res.json({ message: "Quantity decreased", data: user });
      }
    } else {
      return res.json({ message: "Product not in cart", data: user });
    }
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

cartRouter.delete("/remove/:id", authMiddleware, async (req, res) => {
  try {
    const id = req.params.id;
    const product = await Product.findById(id);
    let user = await User.findById(req.user).populate("cart.product");
    let productInCart = false;
    for (i in user.cart) {
      if (user.cart[i].product._id.equals(product._id)) {
        user.cart.splice(i, 1);
        user = await user.save();
        productInCart = true;
      }
    }
    if (productInCart) {
      res.json({ message: "Product removed from cart", data: user });
    } else {
      res.json(404).json({ message: "Product not in cart!" });
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

cartRouter.post("/order", authMiddleware, async (req, res) => {
  try {
    const { totalPrice, address } = req.body;
    let user = await User.findById(req.user);
    let products = [];
    let cart = user.cart;
    for (let i in cart) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res.json({ message: `${product.name} is out of stock!` });
      }
    }
    user.cart = [];
    user = await user.save();
    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getMilliseconds(),
    });
    order = await order.save();
    res.json({ message: "Your order has been placed", data: order });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = cartRouter;
