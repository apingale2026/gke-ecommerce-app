const express = require("express");
const app = express();
app.use(express.json());

app.post("/login", (req, res) => {
    const { username, password } = req.body;
    if (username === "admin" && password === "password123") {
        res.json({ token: "fake-jwt-token-demo" });
    } else {
        res.status(401).json({ error: "Invalid credentials" });
    }
});

app.get("/health", (req, res) => {
    res.json({ status: "ok" });
});

app.listen(3000, "0.0.0.0", () => {
    console.log("Auth running on 3000");
});