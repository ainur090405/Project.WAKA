const express = require("express");
const app = express();
const PORT = 8080;

app.get("/", (req, res) => {
  res.send(`
    <html>
      <head>
        <title>ETS Cloud Computing</title>
        <style>
          body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #f0f2f5; }
          .card { background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); text-align: center; border-top: 5px solid #232f3e; }
          h1 { color: #232f3e; margin-bottom: 0.5rem; }
          p { color: #555; font-size: 1.2rem; }
          .badge { background: #ff9900; color: white; padding: 5px 15px; border-radius: 20px; font-weight: bold; }
        </style>
      </head>
      <body>
        <div class="card">
          <h1>ETS - Arsitektur AWS</h1>
          <p>Nama: <strong>Firmansyah Shurdi</strong></p>
          <p>NRP: <strong>3124522007</strong></p>
          <div class="badge">Server Express Berjalan di EC2!</div>
        </div>
      </body>
    </html>
  `);
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});