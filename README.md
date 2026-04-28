# 📝 Testwise — Computer-Based Testing Platform

> A modern, real-time CBT (Computer-Based Testing) platform with PWA support, built for students, instructors, and administrators.

🔗 **Live Demo:** [testwise-cbt-netlify.app](https://testwise-cbt-netlify.app)

---

## 📖 Overview

Testwise is a full-stack Computer-Based Testing platform that enables institutions to conduct exams digitally. It supports three distinct user roles — each with a dedicated dashboard — and delivers a seamless real-time exam experience powered by WebSockets. The app is also installable as a **Progressive Web App (PWA)**, allowing users to access it directly from their device's home screen.

---

## ✨ Features

### 🎓 Student
- Take exams in a clean, distraction-free interface
- Real-time exam timer powered by Socket.io
- View scores and detailed results immediately after submission
- Access full exam history and performance tracking
- Install the app to home screen (PWA)

### 🧑‍🏫 Instructor
- Create and manage questions and exams
- Assign exams to students or groups
- Monitor student performance with charts and analytics
- View detailed submission breakdowns per exam

### 🛠️ Admin
- Full user management (students, instructors)
- Platform-wide oversight and configuration
- Manage courses and exam categories
- Access platform-level analytics and reports

### ⚡ Real-Time Features (Socket.io)
- Live exam timer synced between client and server
- Real-time exam session management
- Instant result delivery on submission

### 📲 Progressive Web App (PWA)
- Installable on desktop and mobile devices
- Works reliably on low or unstable connections
- Native app-like experience without an app store

---

## 🛠️ Tech Stack

### Frontend (`testwise-client`)
| Technology | Purpose |
|---|---|
| React 18 | UI library |
| Vite | Build tool & dev server |
| TypeScript | Type safety |
| Chakra UI v2 | Component & design system |
| Framer Motion | Animations & transitions |
| TanStack Query | Server state & data fetching |
| React Router v7 | Client-side routing |
| Socket.io Client | Real-time exam communication |
| Recharts | Performance analytics charts |
| Cloudinary | Media management |
| vite-plugin-pwa | PWA support & service worker |

### Backend (`testwise-server`)
| Technology | Purpose |
|---|---|
| Express.js 4 | REST API framework |
| Socket.io | Real-time WebSocket communication |
| Prisma ORM | Database access layer |
| PostgreSQL | Primary database |
| JWT | Authentication & session management |
| Winston | Logging |
| TypeScript | Type safety |

---

## 🚀 Getting Started

### Prerequisites

- Node.js `>= 18`
- npm or pnpm
- PostgreSQL database

### Installation

```bash
# Clone the repository
git clone https://github.com/abdulazeez9/testwise.git
cd testwise
```

```bash
# Install client dependencies
cd testwise-client
npm install

# Install server dependencies
cd ../testwise-server
npm install
```

### Environment Variables

**`testwise-server/.env`**
```env
DATABASE_URL=
DIRECT_URL=
JWT_SECRET=
CLIENT_URL=
PORT=
```

**`testwise-client/.env`**
```env
VITE_API_URL=
VITE_SOCKET_URL=
VITE_CLOUDINARY_CLOUD_NAME=
```

### Database Setup

```bash
cd testwise-server

# Run migrations
npx prisma migrate dev

# Generate Prisma client
npx prisma generate

# Seed the database (optional)
npm run seed
```

### Running the App

```bash
# Start the backend server
cd testwise-server
npm run dev

# Start the frontend (in a new terminal)
cd testwise-client
npm run dev
```

The client will be available at `http://localhost:5173` and the server at `http://localhost:<PORT>`.

### Building for Production

```bash
# Build client
cd testwise-client
npm run build

# Build server
cd testwise-server
npm run build
```

---

## 📲 PWA Installation

Testwise is installable as a Progressive Web App:

1. Open [testwise-cbt-netlify.app](https://testwise-cbt-netlify.app) in your browser
2. Click the **Install** button in the address bar (desktop) or **Add to Home Screen** (mobile)
3. Launch Testwise like a native app directly from your device

---

## 📁 Project Structure

```
testwise/
├── testwise-client/         # React + Vite frontend
│   ├── src/
│   │   ├── components/      # Reusable UI components
│   │   ├── pages/           # Route-level pages (Student, Instructor, Admin)
│   │   ├── hooks/           # Custom React hooks
│   │   ├── services/        # API & socket service layer
│   │   └── utils/           # Helper functions
│   └── vite.config.ts
│
└── testwise-server/         # Express + Socket.io backend
    ├── src/
    │   ├── routes/          # API route handlers
    │   ├── controllers/     # Business logic
    │   ├── middlewares/     # Auth & validation middleware
    │   └── sockets/         # Socket.io event handlers
    └── prisma/
        ├── schema.prisma    # Database schema
        └── seed.ts          # Database seeder
```

---

## 👨‍💻 Author

**Abdulazeez Muritador**
- GitHub: [@abdulazeez9](https://github.com/abdulazeez9)
- Live: [testwise-cbt-netlify.app](https://testwise-cbt-netlify.app)

---

## 📄 License

This project is licensed under the **ISC License**.
