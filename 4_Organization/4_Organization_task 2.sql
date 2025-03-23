-- Определение всех сотрудников, подчиняющихся Ивану Иванову с EmployeeID = 1, включая их подчиненных и подчиненных подчиненных

-- Выводим таблицу для построения иерархии сотрудников
WITH RECURSIVE EmployeeHierarchy AS (
    -- Начинаем с Ивана Иванова (сотрудника с EmployeeID = 1)
    SELECT 
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

    -- Рекурсивно выбираем всех подчиненных
    SELECT 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),

-- Таблица для подсчета количества непосредственных подчиненных для каждого менеджера
SubordinateCounts AS (
    -- Подсчитываем количество непосредственных подчиненных для каждого сотрудника
    SELECT 
        ManagerID,
        COUNT(EmployeeID) AS SubordinateCount
    FROM Employees
    GROUP BY ManagerID
)

-- Извлекаем информацию о сотрудниках и их проектной деятельности
SELECT 
    eh.EmployeeID,
    eh.Name,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    COALESCE(string_agg(DISTINCT p.ProjectName, ', '), 'NULL') AS ProjectNames,  -- Список проектов, в которых участвует сотрудник
    COALESCE(string_agg(DISTINCT t.TaskName, ', '), 'NULL') AS TaskNames,  -- Список задач, назначенных сотруднику
    COALESCE(COUNT(DISTINCT t.TaskID), 0) AS TotalTasks,  -- Общее количество задач, назначенных сотруднику
    COALESCE(sc.SubordinateCount, 0) AS TotalSubordinates  -- Общее количество подчиненных у менеджера
FROM EmployeeHierarchy eh
LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON eh.RoleID = r.RoleID
LEFT JOIN Projects p ON p.DepartmentID = d.DepartmentID
LEFT JOIN Tasks t ON t.AssignedTo = eh.EmployeeID
LEFT JOIN SubordinateCounts sc ON eh.EmployeeID = sc.ManagerID
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName, sc.SubordinateCount  -- Группировка результатов по идентификатору и имени сотрудника, а также по отделу, роли и количеству подчиненных
ORDER BY eh.Name;  -- Сортировка результатов по имени сотрудника