-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, cooking_time, rating) VALUES ('Sandwich', 3, 4);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Pasta', 15, 4);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Pizza', 30, 5);