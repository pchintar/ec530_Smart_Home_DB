# Smart Home Database
SQLite database for tracking household locations, devices, and device activity logs.

## Files
- `smart_home_setup.sql` - database schema

## Setup
```bash
sqlite3 my_smart_home.db < smart_home_setup.sql
```

## Tables
| Table | Purpose |
|-------|---------|
| Household | Stores home and owner info |
| Locations | Rooms, hallways, floors |
| Devices | Lights, sensors, thermostats |
| DeviceLog | History of device actions |

## Soft Delete
Devices table has `is_deleted` column (0 = active, 1 = deleted). Hides devices without losing historical logs.

## Sample Queries
```sql
-- Add a home
INSERT INTO Household (household_name, owner_name) VALUES ('Maple Street', 'Alice');

-- Add a room
INSERT INTO Locations (household_id, location_name, floor_number) VALUES (1, 'Kitchen', 1);

-- Add a device
INSERT INTO Devices (location_id, device_name, device_type, current_value) VALUES (1, 'Fridge Sensor', 'temperature', 38.5);

-- Soft delete a device
UPDATE Devices SET is_deleted = 1 WHERE device_id = 1;

-- View active devices
SELECT * FROM Devices WHERE is_deleted = 0;

-- Log a device event
INSERT INTO DeviceLog (device_id, action, old_value, new_value) VALUES (1, 'temp_change', 38.5, 39.2);
```

## Requirements
- SQLite 3.x
