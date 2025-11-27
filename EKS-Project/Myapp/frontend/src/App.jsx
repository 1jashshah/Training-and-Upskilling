import { useState, useEffect } from "react";

function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState("");

  // Use backend URL from environment variable
  const API_URL = import.meta.env.VITE_API_URL;

  const loadTasks = async () => {
    const res = await fetch(`${API_URL}/tasks`);
    const data = await res.json();
    setTasks(data);
  };

  const addTask = async () => {
    if (!title.trim()) return;

    await fetch(`${API_URL}/tasks`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title }),
    });

    setTitle("");
    loadTasks();
  };

  useEffect(() => {
    loadTasks();
  }, []);

  return (
    <div
      style={{
        maxWidth: "500px",
        margin: "40px auto",
        background: "#fff",
        padding: "20px",
        borderRadius: "8px",
        boxShadow: "0 0 10px rgba(0,0,0,0.1)",
      }}
    >
      <h2 style={{ textAlign: "center" }}>Task Manager</h2>

      <div style={{ display: "flex", marginBottom: "20px" }}>
        <input
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Enter task..."
          style={{
            flex: 1,
            padding: "10px",
            border: "1px solid #ccc",
            borderRadius: "6px",
          }}
        />
        <button
          onClick={addTask}
          style={{
            padding: "10px 20px",
            marginLeft: "10px",
            background: "#007bff",
            border: "none",
            color: "white",
            borderRadius: "6px",
            cursor: "pointer",
          }}
        >
          Add
        </button>
      </div>

      <ul style={{ paddingLeft: "0" }}>
        {tasks.map((t) => (
          <li
            key={t.id}
            style={{
              padding: "10px",
              background: "#fafafa",
              border: "1px solid #ddd",
              marginBottom: "8px",
              borderRadius: "6px",
              listStyle: "none",
            }}
          >
            {t.title}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
