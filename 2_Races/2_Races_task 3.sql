-- Определение классов автомобилей, которые имеют наименьшую среднюю позицию в гонках

-- Вычисление средней позиции и количества гонок для каждого класса автомобилей
WITH ClassAveragePositions AS (
    SELECT 
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM 
        Results r
    JOIN 
        Cars c ON r.car = c.name
    GROUP BY 
        c.class
),

-- Определение минимальной средней позиции
MinAveragePosition AS (
    SELECT 
        MIN(average_position) AS min_average_position
    FROM 
        ClassAveragePositions
),

-- Выбор классов с минимальной средней позицией
FilteredClasses AS (
    SELECT 
        cap.car_class,
        cap.average_position,
        cap.race_count
    FROM 
        ClassAveragePositions cap
    WHERE 
        cap.average_position = (SELECT min_average_position FROM MinAveragePosition)
)

-- Получение информации об автомобилях с классами с минимальной средней позицией
SELECT 
    c.name AS car_name,
    fc.car_class,
    ROUND(fc.average_position, 4) AS average_position,
    fc.race_count,
    cl.country AS car_country,
    SUM(fc.race_count) AS total_races
FROM 
    FilteredClasses fc
JOIN 
    Cars c ON fc.car_class = c.class
JOIN 
    Classes cl ON c.class = cl.class
GROUP BY 
    c.name, fc.car_class, fc.average_position, fc.race_count, cl.country
ORDER BY 
    c.name; -- Сортировка результатов по названию автомобиля