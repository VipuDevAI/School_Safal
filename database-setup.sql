-- School SAFAL Database Setup
-- Run this SQL on your Neon PostgreSQL database

-- Create tables if they don't exist
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  display_name VARCHAR(255),
  is_admin BOOLEAN DEFAULT FALSE,
  assigned_questions JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS questions (
  id SERIAL PRIMARY KEY,
  subject VARCHAR(255),
  question_text TEXT,
  option_a TEXT,
  option_b TEXT,
  option_c TEXT,
  option_d TEXT,
  correct_answer VARCHAR(50),
  image_url TEXT,
  passage_id TEXT,
  passage_text TEXT,
  instruction_text TEXT,
  option_a_image TEXT,
  option_b_image TEXT,
  option_c_image TEXT,
  option_d_image TEXT,
  upload_id VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS responses (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255),
  subject VARCHAR(255),
  score INTEGER,
  answers JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS grades (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255),
  display_name VARCHAR(255),
  subject VARCHAR(255),
  score INTEGER,
  percentage VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS config (
  key VARCHAR(255) PRIMARY KEY,
  value TEXT
);

CREATE TABLE IF NOT EXISTS passages (
  id VARCHAR(255) PRIMARY KEY,
  title TEXT,
  passage_text TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add new columns if they don't exist (for existing databases)
ALTER TABLE questions ADD COLUMN IF NOT EXISTS passage_id TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS passage_text TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS instruction_text TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS option_a_image TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS option_b_image TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS option_c_image TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS option_d_image TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS upload_id VARCHAR(255);

-- Default config values
INSERT INTO config (key, value) VALUES ('ExamActive', 'FALSE') ON CONFLICT (key) DO NOTHING;
INSERT INTO config (key, value) VALUES ('ActiveSubject', 'English') ON CONFLICT (key) DO NOTHING;
INSERT INTO config (key, value) VALUES ('TotalQuestionsPerSubject', '50') ON CONFLICT (key) DO NOTHING;
INSERT INTO config (key, value) VALUES ('ExamDurationMinutes', '60') ON CONFLICT (key) DO NOTHING;

-- Create default admin user (password: admin123)
-- You should change this password after first login
INSERT INTO users (username, password, display_name, is_admin) 
VALUES ('admin', '$2a$10$rIC/oHKhNvN1gXlE5yDqUe.bJbJP0qJz5m5J5N5g5g5g5g5g5g5g5', 'Administrator', TRUE)
ON CONFLICT (username) DO NOTHING;
