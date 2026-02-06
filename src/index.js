const express = require('express');
const { connectDatabase } = require('./connectDatabase');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/', async (req, res) => {
  try {
    const connection = await connectDatabase();
    res.send(`
      <!DOCTYPE html>
      <html>
        <head>
          <title>Node.js MySQL Stack</title>
        </head>
        <body>
          <h1>Hello, world!</h1>
          <p>Successfully connected to MySQL database.</p>
        </body>
      </html>
    `);
    connection.end();
  } catch (error) {
    res.status(500).send(`Database connection error: ${error.message}`);
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
