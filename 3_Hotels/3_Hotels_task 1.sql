-- Определение клиентов, сделавших более двух бронирований в разных отелях

SELECT 
    c.name,
    c.email,
    c.phone,
    COUNT(b.ID_booking) AS total_bookings,   -- Общее количество бронирований для клиента
    STRING_AGG(DISTINCT h.name, ', ') AS hotels,   -- Список названий отелей, в которых останавливался клиент
    ROUND(AVG(b.check_out_date - b.check_in_date), 4) AS average_stay_duration   -- Средняя продолжительность проживания
FROM 
    Customer c
JOIN 
    Booking b ON c.ID_customer = b.ID_customer
JOIN 
    Room r ON b.ID_room = r.ID_room
JOIN 
    Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY 
    c.ID_customer
HAVING 
    COUNT(b.ID_booking) > 2 AND COUNT(DISTINCT r.ID_hotel) > 1  -- Фильтруем клиентов, у которых больше 2 бронирований и которые останавливались более чем в одном отеле
ORDER BY 
    total_bookings DESC;  -- Сортировка результатов по общему количеству бронирований в порядке убывания