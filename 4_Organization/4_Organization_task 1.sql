-- Определение сотрудников, подчиняющихся Ивану Иванову (с EmployeeID = 1), включая их подчиненных и подчиненных подчиненных. 

-- Вычисляем таблицу для построения иерархии сотрудников
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
)

-- Извлекаем информацию о сотрудниках и их проектной деятельности
SELECT 
    eh.EmployeeID,
    eh.Name,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    COALESCE(string_agg(DISTINCT p.ProjectName, ', '), 'NULL') AS ProjectNames,   -- Список проектов, в которых участвует сотрудник
    COALESCE(string_agg(DISTINCT t.TaskName, ', '), 'NULL') AS TaskNames  -- Список задач, назначенных сотруднику
FROM EmployeeHierarchy eh
LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON eh.RoleID = r.RoleID
LEFT JOIN Projects p ON p.DepartmentID = d.DepartmentID
LEFT JOIN Tasks t ON t.AssignedTo = eh.EmployeeID
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName
ORDER BY eh.Name;  -- Сортировка результатов по имени сотрудника