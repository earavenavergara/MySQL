use friendships;

SELECT 
    users.first_name,
    users.last_name,
    users2.first_name AS friend_first_name,
    users2.last_name AS friend_last_name
FROM
    users
        LEFT JOIN
    friendships ON users.id = friendships.user_id
        INNER JOIN
    users AS users2 ON users2.id = friendships.friend_id;
-- 1. Devuelva a todos los usuarios que son amigos de Kermit, asegúrese de que sus nombres se muestren en los resultados.
SELECT 
    users.first_name,
    users.last_name,
    users2.first_name AS friend_first_name,
    users2.last_name AS friend_last_name
FROM
    users
        LEFT JOIN
    friendships ON users.id = friendships.friend_id
        AND users.first_name = 'Kermit'
        INNER JOIN
    users AS users2 ON friendships.user_id = users2.id;
-- 2. Devuelve el recuento de todas las amistades.
SELECT 
    COUNT(friendships.id) AS 'Numero de amistades'
FROM
    friendships;
-- 3. Descubre quién tiene más amigos y devuelve el recuento de sus amigos.
SELECT 
    users.first_name,
    users.last_name,
    COUNT(friendships.id) AS 'Numero de amigos'
FROM
    users
        JOIN
    friendships ON users.id = friendships.user_id
GROUP BY users.id
ORDER BY 'Numero de amigos' DESC
LIMIT 1;
-- 4. Crea un nuevo usuario y hazlos amigos de Eli Byers, Kermit The Frog y Marky Mark.
insert into users (first_name, last_name)
values ("Esteban", "Loreto");
insert into friendships (user_id, friend_id)
values (6, 2),(6,4),(6,5);
-- 5. Devuelve a los amigos de Eli en orden alfabético.
SELECT 
    users.first_name AS friend_first_name,
    users.last_name AS friend_last_name,
    users2.first_name,
    users2.last_name
FROM
    users
        LEFT JOIN
    friendships ON users.id = friendships.user_id
        INNER JOIN
    users AS users2 ON friendships.friend_id = users2.id
        AND users2.first_name = 'Eli'
ORDER BY users.first_name ASC;
-- 6. Eliminar a Marky Mark de los amigos de Eli.
SELECT 
    users2.id AS 'id',
    users2.first_name AS 'first name',
    users2.last_name AS 'last name',
    users.first_name AS 'friend first',
    users.last_name AS 'friend last',
    friendships.friend_id
FROM
    users
        LEFT JOIN
    friendships ON users.id = friendships.friend_id
        AND users.first_name = 'Marky'
        INNER JOIN
    users AS users2 ON friendships.user_id = users2.id
        AND users2.first_name = 'Eli';
DELETE FROM friendships 
WHERE
    user_id = 2 AND friend_id = 5;
-- 7. Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos
SELECT 
    users.first_name,
    users.last_name,
    users2.first_name AS friend_first_name,
    users2.last_name AS friend_last_name
FROM
    users
        LEFT JOIN
    friendships ON users.id = friendships.user_id
        INNER JOIN
    users AS users2 ON friendships.friend_id = users2.id;