---
title: "SQL performance benchmarking queries"
summary: "Script that benchmark the given queries."
description: "Script that benchmark the given queries."
date: 2019-12-17
draft: false
tags: ['sql']
---

## Checking the performance of the query

```sql
DECLARE @r INT;
DECLARE @ts DATETIME;
DECLARE @statement CURSOR;

-- This is the type selected value of the query
DECLARE @dummy AS INT;

DECLARE @results TABLE (elapsed DECIMAL);

SET @r = 0;
WHILE @r < 5
BEGIN
  SET @statement = CURSOR FOR
  -- Replace this QUERY.
  SELECT id FROM employees;

  SET @r = @r + 1
  SET @ts = current_timestamp;

  OPEN @statement;
  FETCH NEXT FROM @statement INTO @dummy;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    FETCH NEXT FROM @statement INTO @dummy;
  END;

  CLOSE @statement;
  DEALLOCATE @statement;

  INSERT INTO @results VALUES (DATEDIFF(MS, @ts, current_timestamp));
END;

SELECT CAST(elapsed AS DECIMAL(10, 5)) AS elapsed FROM @results;
```

### Output

| elapsed (ms)    |
| ----------- |
| 14773.00000 |
| 18177.00000 |
| 14020.00000 |
| 9120.00000  |
| 9450.00000  |

---

## Benchmarking SQL Queries

```sql
DECLARE @ts DATETIME;
DECLARE @repeat INT = 100;
DECLARE @r INT;
DECLARE @i INT;

DECLARE @dummy INT;

DECLARE @statement1 CURSOR;
DECLARE @statement2 CURSOR;

DECLARE @results TABLE (
  run INT,
  statement INT,
  elapsed DECIMAL
);

SET @r = 0;
WHILE @r < 5
BEGIN
  SET @r = @r + 1

  SET @statement1 = CURSOR FOR
    -- Paste statement 1 here
    SELECT id FROM employee_comments;

  SET @statement2 = CURSOR FOR
    -- Paste statement 2 here
    SELECT id FROM employees;

  SET @ts = current_timestamp;
  SET @i = 0;
  WHILE @i < @repeat
  BEGIN
    SET @i = @i + 1

    OPEN @statement1;
    FETCH NEXT FROM @statement1 INTO @dummy;
    WHILE @@FETCH_STATUS = 0
    BEGIN
      FETCH NEXT FROM @statement1 INTO @dummy;
    END;

    CLOSE @statement1;
  END;

  DEALLOCATE @statement1;
  INSERT INTO @results VALUES (@r, 1, DATEDIFF(MS, @ts, current_timestamp));

  SET @ts = current_timestamp;
  SET @i = 0;
  WHILE @i < @repeat
  BEGIN
    SET @i = @i + 1

    OPEN @statement2;
    FETCH NEXT FROM @statement2 INTO @dummy;
    WHILE @@FETCH_STATUS = 0
    BEGIN
      FETCH NEXT FROM @statement2 INTO @dummy;
    END;

    CLOSE @statement2;
  END;

  DEALLOCATE @statement2;
  INSERT INTO @results VALUES (@r, 2, DATEDIFF(MS, @ts, current_timestamp));
END;

SELECT
  statement,
  run,
  CAST(CAST(elapsed / MIN(elapsed) OVER () AS DECIMAL(10, 5)) AS VARCHAR) AS elapsed_ratio
FROM @results
ORDER BY statement, run;
```

### Output

| statement | run | elapsed_ratio |
| --------- | --- | ------------- |
| 1         | 1   | 100.46154     |
| 1         | 2   | 101.76923     |
| 1         | 3   | 91.53846      |
| 1         | 4   | 100.76923     |
| 1         | 5   | 92.07692      |
| 2         | 1   | 1.07692       |
| 2         | 2   | 1.30769       |
| 2         | 3   | 1.53846       |
| 2         | 4   | 1.00000       |
| 2         | 5   | 1.00000       |
