# School SAFAL

## Overview
A complete multi-tenant online assessment system designed for schools, rebuilt from Google Apps Script to a standalone Node.js application. Supports multiple classes (Class V and Class VIII) with separate question banks and user management. Ready for deployment on Render.com with Neon PostgreSQL database.

**Powered by SmartGenEduX 2025**

## Technology Stack
- **Backend:** Node.js with Express.js
- **Database:** PostgreSQL (Neon-compatible)
- **Frontend:** Vanilla HTML/CSS/JavaScript
- **Authentication:** Session tokens with bcrypt password hashing
- **Multi-Tenancy:** Class-based separation (Class V, Class VIII)

## Project Structure
```
├── server.js          # Main Express server
├── database.js        # Database connection and schema
├── routes/
│   ├── auth.js        # Authentication endpoints
│   ├── questions.js   # Question management
│   ├── exam.js        # Exam submission and grading
│   └── admin.js       # Admin dashboard APIs
├── public/
│   ├── index.html     # Main frontend
│   ├── styles.css     # Styling
│   └── app.js         # Frontend JavaScript
├── Procfile           # Railway deployment
├── railway.json       # Railway configuration
└── .env.example       # Environment variables template
```

## Features
1. **User Authentication**
   - Login/logout with session tokens
   - Admin and student roles
   - Secure password hashing

2. **Exam System**
   - Random question assignment per student
   - Timed exams with countdown
   - Question navigation (prev/next)
   - Image support for questions
   - Auto-submit when timer ends

3. **Admin Dashboard**
   - Bulk user upload via CSV
   - Question bank management
   - Enable/disable exams
   - Set active subject for the day
   - View reports and export CSV

## Database Schema
- **users:** Student and admin accounts
- **questions:** Question bank with options
- **responses:** Exam submissions
- **grades:** Calculated scores
- **config:** System settings

## Deployment to Railway

### Prerequisites
1. Railway account (https://railway.app)
2. Neon PostgreSQL database (https://neon.tech)

### Steps
1. Create a Neon database and copy the connection string
2. Push code to GitHub repository
3. In Railway:
   - Create new project from GitHub
   - Add environment variable: `DATABASE_URL` = your Neon connection string
   - Deploy will start automatically
4. Access via Railway-generated domain

### Environment Variables
| Variable | Description |
|----------|-------------|
| DATABASE_URL | Neon PostgreSQL connection string |
| PORT | Server port (Railway sets automatically) |
| NODE_ENV | Set to "production" for deployment |

## Default Admin Credentials
- Username: `smartadmin`
- Password: `SmartGen@2025`

**Important:** Change the admin password after first login!

## API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/logout` - User logout

### Exam
- `POST /api/exam/get-active-subject` - Get current subject
- `POST /api/exam/submit` - Submit exam answers

### Questions
- `POST /api/questions/get-question` - Fetch question by index

### Admin
- `POST /api/admin/bulk-create-users` - Upload users via CSV
- `POST /api/admin/upload-questions` - Upload questions via CSV
- `POST /api/admin/set-exam-active` - Enable/disable exam
- `POST /api/admin/set-active-subject` - Set today's subject
- `POST /api/admin/set-total-questions` - Set question count
- `POST /api/admin/get-summary` - Get results summary
- `POST /api/admin/export-csv` - Export responses as CSV

## Word Document Format for Questions

### Markers
| Symbol | Purpose | Example |
|--------|---------|---------|
| `@@` | Passages & Poems | `@@READ THE PASSAGE AND ANSWER THE FOLLOWING QUESTIONS` |
| `##` | Instructions/Headings | `##PICK OUT THE SUITABLE PREPOSITION` |

### Sample Format
```
@@READ THE PASSAGE AND ANSWER THE FOLLOWING QUESTIONS

The Grand Canyon is one of the most famous natural wonders...

1. Where is the Grand Canyon located?
A) California
B) Arizona
C) Nevada
D) Texas
Answer: B

##PICK OUT THE SUITABLE PREPOSITION

2. She walked _______ the crowd.
A) through
B) over
C) across
D) under
Answer: A
```

### Rules
1. `@@` before passages/poems (passage text follows, then questions)
2. `##` before instruction headings (Pick out, Choose, Fill in, etc.)
3. Questions: Number with period `1.`, `2.`, `3.`
4. Options: `A)`, `B)`, `C)`, `D)`
5. Answer: `Answer: B`
6. Fractions: Type as plain text `1/2`, `3/5`
7. Blanks: Use underscores `_______`
8. Images: Embedded images in Word are automatically extracted

## Recent Changes
- December 2025: Added multi-tenancy with Class V and Class VIII support
- December 2025: Added class dropdown to login page
- December 2025: Added class selection for user upload and question upload in admin
- December 2025: Added footer "Powered by SmartGenEduX 2025"
- December 2025: Changed admin credentials to smartadmin/SmartGen@2025
- December 2025: Question navigator moved to right sidebar (5x10 grid)
- December 2025: Added Marked for Review section in sidebar
- November 2025: Added Session Resume feature (students can resume after refresh/internet issues)
- November 2025: Added Analytics Dashboard with charts, top performers, score distribution
- November 2025: Fixed question navigator (Answered, Not Answered, Marked for Review)
- November 2025: Fixed timer color to pale green (less anxiety for students)
- November 2025: Fixed questions starting with blanks (e.g., "1. _______ is the capital")
- November 2025: Fixed fraction options (1/2, 3/5) no longer eliminated
- November 2025: Fixed School SAFAL branding (SAFAL in caps, centered)
- November 2025: Fixed bulk upload to accept any username/password format (including numbers)
- November 2025: Added Word document parser with @@ and ## markers
- Passage and instruction text display with questions during exam
- Students never see scores (admin only)
- Initial build: November 2025
- Converted from Google Apps Script to Node.js/Express
- Added PostgreSQL database support for Neon
- Created Railway deployment configuration
