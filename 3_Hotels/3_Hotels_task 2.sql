-- Определение клиентов, которые сделали более двух бронирований в разных отелях и потратили более 500 долларов на свои бронирования

SELECT 
    c.ID_customer,
    c.name,
    COUNT(b.ID_booking) AS total_bookings, -- Общее количество бронирований для клиента
    SUM(r.price * (b.check_out_date - b.check_in_date)) AS total_spent,  -- Общая сумма, потраченная клиентом на бронирования
    COUNT(DISTINCT h.ID_hotel) AS unique_hotels  -- Количество отелей, в которых останавливался клиент
FROM 
    Customer c
JOIN 
    Booking b ON c.ID_customer = b.ID_customer
JOIN 
    Room r ON b.ID_room = r.ID_room
JOIN 
    Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY 
    c.ID_customer, c.name
HAVING 
    COUNT(b.ID_booking) > 2 -- Фильтруем клиентов с более чем 2 бронированиями
    AND COUNT(DISTINCT h.ID_hotel) > 1   -- Фильтруем клиентов, останавливавшихся более чем в одном отеле
    AND SUM(r.price * (b.check_out_date - b.check_in_date)) > 500   -- Фильтруем клиентов, которые потратили более 500
ORDER BY 
    total_spent ASC;  -- Сортировка результатов по общей сумме расходов в порядке возрастания