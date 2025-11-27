const express = require("express");
const cors = require("cors");
const mysql = require("mysql2");

const app = express();
app.use(express.json());
app.use(cors());

// MySQL connection
const db = mysql.createConnection({
  host: "taskdb.cvkeqy8c2n2t.ap-south-1.rds.amazonaws.com",
  user: "taskuser",
  password: "password123",
  database: "taskdb",
});

db.connect(err => {
    if (err) {
        console.log("Database connection error", err);
        return;
    }
    console.log("MySQL Connected");
});

// Root route
app.get("/", (req, res) => {
  res.send("Backend is running...");
});

// Create table
db.query(`
    CREATE TABLE IF NOT EXISTS tasks (
        id INT AUTO_INCREMENT PRIMARY KEY,
        task VARCHAR(255)
    )
`);

// Add Task
app.post("/add", (req, res) => {
    console.log("📩 Data received from frontend:", req.body);  // <-- ADD THIS

    const { task } = req.body;
    if (!task) return res.status(400).send("Task is required");

    db.query("INSERT INTO tasks (name) VALUES (?)", [task], (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).send("DB error");
        }
        res.send({ message: "Task added", id: result.insertId });
    });
});


// Get Tasks
app.get("/tasks", (req, res) => {
    db.query("SELECT * FROM tasks", (err, data) => {
        if (err) return res.status(500).send("DB error");
        res.send(data);
    });
});

app.listen(5000, () => {
    console.log("Server running on port 5000");
});
