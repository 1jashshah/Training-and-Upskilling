const express = require('express');
const app = express();
app.use(express.json());

const books = [
  { id: 1, title: "DevOps Handbook", author: "Gene Kim" },
  { id: 2, title: "Kubernetes Up & Running", author: "Kelsey Hightower" }
];

app.get('/books', (req, res) => res.json(books));
app.listen(5000, () => console.log("Book Service running on port 5000"));

