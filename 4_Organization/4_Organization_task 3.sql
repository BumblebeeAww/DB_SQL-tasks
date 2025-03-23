-- Определение сотрудников, которые занимают роль менеджера и имеют подчиненных (то есть число подчиненных больше 0)

-- Таблица для построения иерархии менеджеров
WITH RECURSIVE ManagerHierarchy AS (
    -- Выбираем менеджеров, у которых есть подчиненные	
    SELECT 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID,
        e.EmployeeID AS RootManagerID
    FROM 
        Employees e
    INNER JOIN 
        Roles r ON e.RoleID = r.RoleID
    WHERE 
        r.RoleName = 'Менеджер'  -- Выбор только с указанной ролью
        AND EXISTS (  -- Проверка, есть ли у менеджера подчиненные
            SELECT 1 
            FROM Employees sub 
            WHERE sub.ManagerID = e.EmployeeID
        )
    
    UNION ALL
    
    -- Выбираем подчиненных менеджеров
    SELECT 
        sub.EmployeeID,
        sub.Name,
        sub.ManagerID,
        sub.DepartmentID,
        sub.RoleID,
        mh.RootManagerID
    FROM 
        Employees sub
    INNER JOIN 
        ManagerHierarchy mh 
        ON sub.ManagerID = mh.EmployeeID
)

-- Извлечение информации о менеджерах и их подчиненных
SELECT 
    m.RootManagerID AS EmployeeID,
    emp.Name AS EmployeeName,
    emp.ManagerID,
    d.DepartmentName,
    r.RoleName,
    (SELECT STRING_AGG(p.ProjectName, ', ') 
     FROM Projects p 
     WHERE p.DepartmentID = emp.DepartmentID) AS ProjectNames,  -- Список проектов, связанных с отделом сотрудника
    (SELECT STRING_AGG(t.TaskName, ', ') 
     FROM Tasks t 
     WHERE t.AssignedTo = emp.EmployeeID) AS TaskNames,  -- Список задач, назначенных сотруднику
    (SELECT COUNT(*) - 1 
     FROM ManagerHierarchy mh_count 
     WHERE mh_count.RootManagerID = emp.EmployeeID) AS TotalSubordinates  -- Общее количество подчиненных у менеджера
FROM 
    (SELECT DISTINCT RootManagerID FROM ManagerHierarchy) m  -- Получаем уникальные идентификаторы 
INNER JOIN 
    Employees emp 
    ON m.RootManagerID = emp.EmployeeID
LEFT JOIN 
    Departments d 
    ON emp.DepartmentID = d.DepartmentID
LEFT JOIN 
    Roles r 
    ON emp.RoleID = r.RoleID
WHERE 
    r.RoleName = 'Менеджер'  
ORDER BY 
    emp.Name;  -- Сортировка результатов по имени сотрудника