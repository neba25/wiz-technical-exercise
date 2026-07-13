require("dotenv").config();

const express = require("express");
const cors = require("cors");

const connectDB = require("./config/db");
const taskRoutes = require("./routes/taskRoutes");

const app = express();

connectDB();

app.use(cors());
app.use(express.json());

// Root endpoint
app.get("/", (req, res) => {
    res.send("THIS IS THE NEW ROOT ROUTE");
});

// Health endpoint
app.get("/health", (req, res) => {
    res.status(200).json({
        status: "UP",
        database: "Connected"
    });
});

app.use("/api/tasks", taskRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});