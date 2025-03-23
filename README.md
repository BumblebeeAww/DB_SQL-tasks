# DB_SQL tasks

## 1. Описание проекта
Данный проект представляет собой систему работы с четырьмя различными базами данных: 
- транспортные средства
- автомобильные гонки
- бронирование отелей
- структура организации. 
Цель работы — отработка навыков с базами данных, используя язык SQL.  

## 2. Цели и задачи 
Создание базы данных: Разработать структуру баз данных.
Наполнение данными: Заполнить таблицы тестовыми данными для последующего анализа.
Решение задач: Реализовать функционал для выполнения различных запросов и операций с данными.

## 3. Структура проекта
```
DB_SQL tasks
│
├── 1_Transport
│ ├── 1_Create Transport tables.sql
│ ├── 1_Transport_main tables.sql
│ ├── 1_Transport_task 1.sql
│ └── 1_Transport_task 2.sql
│
├── 2_Races
│ ├── 2_Create Races tables.sql
│ ├── 2_Races_main tables.sql
│ ├── 2_Races_task 1.sql
│ ├── 2_Races_task 2.sql
│ ├── 2_Races_task 3.sql
│ ├── 2_Races_task 4.sql
│ └── 2_Races_task 5.sql
│
├── 3_Hotels
│ ├── 3_Create Hotels tables.sql
│ ├── 3_Hotels_main tables.sql
│ ├── 3_Hotels_task 1.sql
│ ├── 3_Hotels_task 2.sql
│ └── 3_Hotels_task 3.sql
│
└── 4_Organization
  ├── 4_Create Organization tables.sql
  ├── 4_Organization_main tables.sql
  ├── 4_Organization_task 1.sql
  ├── 4_Organization_task 2.sql
  └── 4_Organization_task 3.sql
```

## 4. Инструкция по запуску
1) Создайте базу данных в PostgreSQL. Пример команды для создания базы данных:

`CREATE DATABASE mydatabase;`

2) Подключитесь к базе данных. Например:

`psql -U postgres -d mydatabase`

3) Создайте таблицы и заполните их данными. 

4) Выполните решение задачи, используя приложенные скрипты.

## 5. Заключение
Данный проект предоставляет возможность изучить и применить на практике основные аспекты работы с реляционными базами данных.


