import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { errorHandler } from './middleware/errorHandler.js';
import { createServer } from 'http';
import webSocketService from './v1/services/webSocketService.js';
import { setupRoutes } from './v1/routes/index.js';

// Configure dotenv
dotenv.config();

//App initialization
const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

//Setup routes
setupRoutes(app);

// Error handling
app.use(errorHandler);

const server = createServer(app);
webSocketService.init(server);

server.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
