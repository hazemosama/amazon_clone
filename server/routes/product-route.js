const express = require("express");
const productRouter = express.Router();
const Product = require("../models/product-model").Product;
const authMiddleware = require("../middlewares/auth-middleware");

productRouter.get("/", authMiddleware, async (req, res) => {
  try {
    const products = await Product.find({
      category: { $regex: req.query.category, $options: "i" },
    });
    res.json({ message: "Successfully fetched products", data: products });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/search/:name", authMiddleware, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json({ message: "Successfully fetched products", data: products });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.post("/rate-product", authMiddleware, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);
    for (let i in product.ratings) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.ratings.push(ratingSchema);

    res.json({ message: "Product rated successfully", data: product });

    product = await product.save();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/today-deals", authMiddleware, async (req, res) => {
  try {
    let products = await Product.find({});

    products = products.sort((a, b) => {
      let r1Sum = 0;
      let r2Sum = 0;

      for (let i = 0; i < a.ratings.length; i++) {
        r1Sum += a.ratings[i].rating;
      }

      for (let i = 0; i < b.ratings.length; i++) {
        r2Sum += b.ratings[i].rating;
      }
      return r1Sum < r2Sum ? 1 : -1;
    });
    res.json({
      message: "Successfully get today's deals",
      data: products.slice(0, 4),
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = productRouter;
