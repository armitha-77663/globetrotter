
CREATE DATABASE IF NOT EXISTS globetrotter;
USE globetrotter;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    trip_name VARCHAR(150) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    estimated_budget DECIMAL(10,2),

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

CREATE TABLE trip_stops (
    stop_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    arrival_date DATE NOT NULL,
    departure_date DATE NOT NULL,

    FOREIGN KEY (trip_id)
        REFERENCES trips(trip_id)
        ON DELETE CASCADE
);

-- ===============================
-- 4. ACTIVITIES (MASTER TABLE)
-- ===============================
CREATE TABLE activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    average_cost DECIMAL(8,2)
);

CREATE TABLE trip_activities (
    trip_activity_id INT AUTO_INCREMENT PRIMARY KEY,
    stop_id INT NOT NULL,
    activity_id INT NOT NULL,
    activity_date DATE NOT NULL,
    time_slot VARCHAR(50),
    cost DECIMAL(8,2),

    FOREIGN KEY (stop_id)
        REFERENCES trip_stops(stop_id)
        ON DELETE CASCADE,

    FOREIGN KEY (activity_id)
        REFERENCES activities(activity_id)
        ON DELETE CASCADE
);

INSERT INTO users (name, email, password)
VALUES ('Lilly', 'lilly@gmail.com', 'hashed_password');

INSERT INTO trips (user_id, trip_name, description, start_date, end_date, estimated_budget)
VALUES (1, 'Europe Trip', 'Vacation across Europe', '2026-01-10', '2026-01-25', 200000);

INSERT INTO trip_stops (trip_id, city, arrival_date, departure_date)
VALUES (1, 'Paris', '2026-01-10', '2026-01-15');

INSERT INTO activities (name, category, average_cost)
VALUES ('Eiffel Tower Visit', 'Sightseeing', 2500);

INSERT INTO trip_activities (stop_id, activity_id, activity_date, time_slot, cost)
VALUES (1, 1, '2026-01-11', 'Morning', 2600);
