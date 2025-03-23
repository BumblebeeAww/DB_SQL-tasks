-- Производители и модели мотоциклов, мощностью более 150 л.с., стоимостью менее 20000 долларов, тип Sport
SELECT v.maker, m.model
FROM Motorcycle m
JOIN Vehicle v ON m.model = v.model
WHERE m.horsepower > 150 -- Выбираем мотоциклы мощностью более 150 л.с.
  AND m.price < 20000 -- стоимостью менее 20000 долларов
  AND m.type = 'Sport' -- и типом Sport
ORDER BY m.horsepower DESC; -- Сортировка по мощности в порядке убывания