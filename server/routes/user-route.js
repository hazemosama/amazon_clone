const express = require("express");
const User = require("../models/user-model");
const userRouter = express.Router();
const authMiddleware = require("../middlewares/auth-middleware");

userRouter.get("/get-user-data", authMiddleware, async (req, res) => {
  try {
    const user = await User.findById(req.user).populate("cart.product");
    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product.quantity == 0) {
        user.cart.splice(i, 1);
        user = await user.save();
      }
    }
    res.json({
      message: "successfully get data",
      data: { ...user._doc, token: req.token },
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post("/save-address", authMiddleware, async (req, res) => {
  try {
    const address = req.body.address;
    let user = await User.findById(req.user).populate("cart.product");
    user.address = address;
    user = await user.save();
    res.json({
      message: "address saved successfully",
      data: { ...user._doc },
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
