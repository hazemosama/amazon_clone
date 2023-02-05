const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth-route");
const adminRouter = require("./routes/admin-route");
const productRouter = require("./routes/product-route");
const cartRouter = require("./routes/cart-route");
const userRouter = require("./routes/user-route");

const PORT = process.env.port || 3000;
const DB =
  "mongodb+srv://hazem:110200@cluster0.hg8ydor.mongodb.net/?retryWrites=true&w=majority";
const app = express();

//middlewares
app.use(express.json());
app.use("/api/auth", authRouter);
app.use("/api/admin", adminRouter);
app.use("/api/products", productRouter);
app.use("/api/cart", cartRouter);
app.use("/api/user", userRouter);

//connections
mongoose.set("strictQuery", false);

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection To DB Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
