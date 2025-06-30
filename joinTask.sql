create database joinTask

-- DDL:

CREATE TABLE Servers ( 
    server_id INT PRIMARY KEY, 
    server_name VARCHAR(50), 
    region VARCHAR(50) 
);


CREATE TABLE Alerts ( 
    alert_id INT PRIMARY KEY, 
    server_id INT, 
    alert_type VARCHAR(50), 
    severity VARCHAR(20) 
);


CREATE TABLE AI_Models ( 
    model_id INT PRIMARY KEY, 
    model_name VARCHAR(50), 
    use_case VARCHAR(50) 
);


CREATE TABLE ModelDeployments ( 
    deployment_id INT PRIMARY KEY, 
    server_id INT, 
    model_id INT, 
    deployed_on DATE 
);


-- DML:
INSERT INTO Servers VALUES 
(1, 'web-server-01', 'us-east'), 
(2, 'db-server-01', 'us-east'), 
(3, 'api-server-01', 'eu-west'), 
(4, 'cache-server-01', 'us-west');


INSERT INTO Alerts VALUES 
(101, 1, 'CPU Spike', 'High'), 
(102, 2, 'Disk Failure', 'Critical'), 
(103, 2, 'Memory Leak', 'Medium'), 
(104, 5, 'Network Latency', 'Low'); -- Invalid server_id (edge case)


INSERT INTO AI_Models VALUES 
(201, 'AnomalyDetector-v2', 'Alert Prediction'), 
(202, 'ResourceForecaster', 'Capacity Planning'), 
(203, 'LogParser-NLP', 'Log Analysis');


INSERT INTO ModelDeployments VALUES 
(301, 1, 201, '2025-06-01'), 
(302, 2, 201, '2025-06-03'), 
(303, 2, 202, '2025-06-10'), 
(304, 3, 203, '2025-06-12');


-- Join Practice:

-- Task 1: INNER JOIN:
-- List all alerts with the corresponding server name.

select A.alert_id, S.server_name
from Alerts A inner join Servers S on A.server_id = S.server_id


-- Task 2: LEFT JOIN:
-- List all servers and any alerts they might have received.

select A.alert_id, S.server_name
from Servers S left join Alerts A on S.server_id = A.server_id



-- Task 3: RIGHT JOIN:
-- Show all alerts and the server name that triggered them, including alerts without a matching server.

select A.alert_id, S.server_name
from Servers S right join Alerts A on S.server_id = A.server_id


-- Task 4: FULL OUTER JOIN:
-- List all servers and alerts, including unmatched ones on both sides.

select A.alert_id, S.server_name
from Servers S full join Alerts A on S.server_id = A.server_id


-- Task 5: CROSS JOIN:
-- Pair every AI model with every server (e.g., simulation of possible deployments).

select A.model_name, S.server_name
from AI_Models A cross join Servers S