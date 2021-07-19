-- 1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?
SELECT 
    EXTRACT(MONTH FROM billing.charged_datetime) AS 'month',
    SUM(billing.amount) AS revenue
FROM
    billing
WHERE
    billing.charged_datetime >= '2012/03/01'
        AND billing.charged_datetime < '2012/04/01';
-- 2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?
SELECT 
    clients.client_id,
    CONCAT(clients.first_name,
            ' ',
            clients.last_name) AS client_name,
    SUM(billing.amount) AS revenue
FROM
    clients
        JOIN
    billing ON clients.client_id = billing.client_id
        AND clients.client_id = 2
GROUP BY client_name;
-- 3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?
SELECT 
    clients.client_id,
    CONCAT(clients.first_name,
            ' ',
            clients.last_name) AS client_name,
    sites.domain_name
FROM
    clients
        JOIN
    sites ON clients.client_id = sites.client_id
        AND clients.client_id = 10;
-- 4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por mes por año para el cliente con una identificación de 1? ¿Qué pasa con el cliente = 20?

-- 5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados para cada uno de los sitios entre el 1 de enero de 2011 y el 15 de febrero de 2011?
SELECT 
    COUNT(leads.leads_id) AS '# of leads',
    sites.domain_name,
    leads.registered_datetime
FROM
    sites
        JOIN
    leads ON sites.site_id = leads.site_id
        AND leads.registered_datetime >= '2011-01-01'
        AND leads.registered_datetime <= '2011-02-15'
GROUP BY sites.domain_name;
-- 6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?
SELECT 
    CONCAT(clients.first_name,
            ' ',
            clients.last_name) AS 'client_name',
    COUNT(leads.leads_id) AS 'number_of_leads'
FROM
    clients
        LEFT JOIN
    sites ON clients.client_id = sites.client_id
        LEFT JOIN
    leads ON sites.site_id = leads.site_id
        AND leads.registered_datetime >= '2011-01-01'
        AND leads.registered_datetime <= '2011-12-31'
GROUP BY clients.client_id
ORDER BY '# of leads' DESC;
-- 7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011?
SELECT 
    CONCAT(clients.first_name,
            ' ',
            clients.last_name) AS 'client name',
    COUNT(leads.leads_id) AS '# of leads',
    MONTH(leads.registered_datetime) AS 'month'
FROM
    clients
        LEFT JOIN
    sites ON clients.client_id = sites.client_id
        JOIN
    leads ON sites.site_id = leads.site_id
        AND leads.registered_datetime >= '2011-01-01'
        AND leads.registered_datetime < '2011-07-01'
GROUP BY clients.client_id , MONTH(leads.registered_datetime)
ORDER BY '# of leads' DESC;
-- 8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre todos los clientes, los nombres del sitio y el número total de clientes potenciales generados en cada sitio en todo momento.
SELECT 
    clients.client_id,
    CONCAT(clients.first_name,
            ' ',
            clients.last_name) AS 'client name',
    sites.domain_name,
    COUNT(leads.leads_id) AS '# of leads'
FROM
    clients
        LEFT JOIN
    sites ON clients.client_id = sites.client_id
        JOIN
    leads ON sites.site_id = leads.site_id
        AND leads.registered_datetime >= '2011-01-01'
        AND leads.registered_datetime <= '2011-12-31'
GROUP BY sites.domain_name
ORDER BY clients.client_id ASC;
-- 9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. Pídalo por ID de cliente.
SELECT 
    clients.client_id,
    CONCAT(clients.first_name,
            ' ',
            clients.last_name) AS 'client_name',
    SUM(billing.amount) AS revenue,
    MONTH(billing.charged_datetime) AS 'month',
    YEAR(billing.charged_datetime) AS 'year'
FROM
    clients
        JOIN
    billing ON clients.client_id = billing.client_id
GROUP BY clients.client_id , MONTH(billing.charged_datetime)
ORDER BY clients.client_id ASC , MONTH(billing.charged_datetime) ASC , YEAR(billing.charged_datetime) ASC;
-- 10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. Agrupe los resultados para que cada fila muestre un nuevo cliente. Se volverá más claro cuando agregue un nuevo campo llamado 'sitios' que tiene todos los sitios que posee el cliente. (SUGERENCIA: use GROUP_CONCAT)
SELECT 
    clients.client_id,
    CONCAT(clients.first_name,
            ' ',
            clients.last_name) AS 'client_name',
    GROUP_CONCAT(' ', sites.domain_name) AS 'sites'
FROM
    clients
        LEFT JOIN
    sites ON clients.client_id = sites.client_id
GROUP BY clients.client_id;