const { json } = require("express");
const express = require("express");
const adminRouter = express.Router();
const adminMiddleware = require("../middlewares/admin-middleware");
const Product = require("../models/product-model").Product;

// Add product
adminRouter.post("/add-product", adminMiddleware, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product._doc);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all products
adminRouter.get("/get-products", adminMiddleware, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json({ message: "Successfully fetched products", data: products });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.delete("/delete-product/:id", adminMiddleware, async (req, res) => {
  try {
    const id = req.params.id;
    let product = await Product.findByIdAndDelete(id);
    res.json({ message: "Product deleted successfully" });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
