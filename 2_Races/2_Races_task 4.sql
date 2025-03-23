-- Определение автомобилей, имеющих среднюю позицию лучше (меньше) средней позиции всех автомобилей в своем классе

-- Вычисление средней позиции и количества гонок для каждого класса автомобилей
WITH ClassAveragePositions AS (
    SELECT 
        c.class AS car_class,
        AVG(r.position) AS average_class_position,
        COUNT(r.race) AS race_count
    FROM 
        Results r
    JOIN 
        Cars c ON r.car = c.name
    GROUP BY 
        c.class
    HAVING 
        COUNT(r.race) > 1  -- Убедимся, что в классе минимум два автомобиля
),

-- Вычисление средней позиции и количества гонок для каждого автомобиля
CarAveragePositions AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count,
        cl.country AS car_country
    FROM 
        Results r
    JOIN 
        Cars c ON r.car = c.name
    JOIN 
        Classes cl ON c.class = cl.class
    GROUP BY 
        c.name, c.class, cl.country
)

-- Определение автомобилей, средняя позиция которых ниже средней позиции их класса
SELECT 
    cap.car_name,
    cap.car_class,
    ROUND(cap.average_position, 4) AS average_position,
    cap.race_count,
    cap.car_country
FROM 
    CarAveragePositions cap
JOIN 
    ClassAveragePositions cap_avg ON cap.car_class = cap_avg.car_class
WHERE 
    cap.average_position < cap_avg.average_class_position
ORDER BY 
    cap.car_class,  -- Сортировка результатов по классу автомобиля
    cap.average_position;  -- Сортировка результатов по средней позиции автомобиля