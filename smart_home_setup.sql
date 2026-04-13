PRAGMA foreign_keys = ON;

-- Each home belongs to one owner
CREATE TABLE IF NOT EXISTS Household (
    household_id INTEGER PRIMARY KEY AUTOINCREMENT,
    household_name TEXT NOT NULL,
    owner_name TEXT NOT NULL
);

-- Rooms or areas inside a household
CREATE TABLE IF NOT EXISTS Locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    household_id INTEGER NOT NULL,
    location_name TEXT NOT NULL,
    floor_number INTEGER DEFAULT 1,
    FOREIGN KEY (household_id) REFERENCES Household(household_id) ON DELETE CASCADE
);

-- Devices placed in specific locations. is_deleted = 1 means soft deleted.
CREATE TABLE IF NOT EXISTS Devices (
    device_id INTEGER PRIMARY KEY AUTOINCREMENT,
    location_id INTEGER NOT NULL,
    device_name TEXT NOT NULL,
    device_type TEXT NOT NULL,
    current_value REAL,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_deleted INTEGER DEFAULT 0,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) ON DELETE CASCADE
);

-- Logs every change a device makes
CREATE TABLE IF NOT EXISTS DeviceLog (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    device_id INTEGER NOT NULL,
    action TEXT NOT NULL,
    old_value REAL,
    new_value REAL,
    log_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (device_id) REFERENCES Devices(device_id) ON DELETE CASCADE
);
