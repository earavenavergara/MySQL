USE twitter;
SELECT * FROM users;
INSERT INTO users(first_name,last_name,handle,birthday,created_at,updated_at)
VALUE ('Esteban','Aravena','asd','1988-04-06',NOW(),NOW());
UPDATE users SET handle = 'Hola!!' WHERE id = 13;
DELETE FROM users WHERE id = 13;