import mysql from "mysql2";

export const db = mysql.createConnection({
  host: "taskdb.cvkeqy8c2n2t.ap-south-1.rds.amazonaws.com",
  user: "taskuser",
  password: "password123",
  database: "taskdb"
});

db.connect((err) => {
  if (err) {
    console.log("MySQL Connection Failed:", err);
    return;
  }
  console.log("MySQL Connected Successfully");
});
