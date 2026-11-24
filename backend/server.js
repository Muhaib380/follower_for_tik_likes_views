// 1. Packages ko import kiya (require ke zariye)
const express = require("express");
const cors = require("cors");

// 2. Express application banayi
const app = express();

// 3. Middlewares (Security & JSON support)
app.use(cors()); // Flutter app ko request bhejne ki permission deta hai
app.use(express.json()); // JSON data read karne ke liye

// 4. Test Route (Homepage)
// Jab koi browser ya Flutter se http://localhost:5000 par aayega:
app.get("/", (req, res) => {
  res.json({
    status: "success",
    message: "TrendSpark Backend is running live! 🚀",
    developer: "Muhib",
    time: new Date().toLocaleTimeString(),
  });
});

// 5. Server ko port 5000 par start kiya
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`==========================================`);
  console.log(`🚀 TrendSpark Server Started!`);
  console.log(`📡 URL: http://localhost:${PORT}`);
  console.log(`==========================================`);
});
