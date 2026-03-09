const express = require("express");

const app = express();
app.use(express.json());

const PORT = 3000;

app.get("/health", (req, res) => {
  res.status(200).json({
    status: "healthy",
    uptime: process.uptime()
  });
});

app.get("/status", (req, res) => {
  res.json({
    status: "running",
    timestamp: new Date()
  });
});

app.post("/process", (req, res) => {

  const data = req.body;

  console.log("Processing data:", data);

  res.json({
    message: "Data processed successfully",
    received: data
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});