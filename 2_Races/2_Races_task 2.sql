-- Определение автомобиля, который имеет наименьшую среднюю позицию в гонках среди всех автомобилей

-- Вычисление средней позиции и количества гонок для каждого автомобиля
WITH AveragePositions AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM 
        Results r
    JOIN 
        Cars c ON r.car = c.name
    GROUP BY 
        c.name, c.class
)
SELECT -- Определяем автомобили с наименьшей средней позицией
    ap.car_name,
    ap.car_class,
    ROUND(ap.average_position, 4) AS average_position,
    ap.race_count,
    cl.country
FROM 
    AveragePositions ap
JOIN 
    Classes cl ON ap.car_class = cl.class
ORDER BY -- Сортируем результаты по средней позиции в порядке возрастания
    ap.average_position ASC, 
    ap.car_name ASC
LIMIT 1; -- Определяем один автомобиль с наименьшей средней позицией