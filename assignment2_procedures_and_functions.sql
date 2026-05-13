-- ASSIGNMENT 2: Procedures and Functions for Salary Management
-- This assignment covers PL/SQL stored procedures and functions with DML operations

-- Prerequisites: Run Assignment 1 first to create the EMP table

-- 2) Procedure: update salary for given empno (updates table directly)
CREATE OR REPLACE PROCEDURE proc_update_salary(p_empno IN emp.empno%TYPE) IS
  v_sal emp.sal%TYPE;
BEGIN
  SELECT sal INTO v_sal FROM emp WHERE empno = p_empno;

  IF v_sal > 10000 THEN
    UPDATE emp
    SET sal = TRUNC(sal * 1.06, 2)
    WHERE empno = p_empno;
  ELSE
    UPDATE emp
    SET sal = TRUNC(sal * 1.05, 2)
    WHERE empno = p_empno;
  END IF;
  -- Commit removed to let caller control transaction if desired.
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Procedure: Employee not found: ' || p_empno);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Procedure Error: ' || SQLERRM);
    RAISE;
END proc_update_salary;
/

-- 3) Function: calculate the new salary for given empno, update table, and return new salary
CREATE OR REPLACE FUNCTION fn_calc_and_update_salary(p_empno IN emp.empno%TYPE) RETURN NUMBER IS
  v_sal   emp.sal%TYPE;
  v_new   NUMBER;
BEGIN
  SELECT sal INTO v_sal FROM emp WHERE empno = p_empno;

  IF v_sal > 10000 THEN
    v_new := TRUNC(v_sal * 1.06, 2);
  ELSE
    v_new := TRUNC(v_sal * 1.05, 2);
  END IF;

  UPDATE emp SET sal = v_new WHERE empno = p_empno;
  RETURN v_new;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Function: Employee not found: ' || p_empno);
    RETURN NULL;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Function Error: ' || SQLERRM);
    RAISE;
END fn_calc_and_update_salary;
/

-- 4) Examples: call the procedure and function, and show results.
SET SERVEROUTPUT ON

-- Example call: procedure
BEGIN
  DBMS_OUTPUT.PUT_LINE('Before proc: ' || (SELECT TO_CHAR(sal) FROM emp WHERE empno = 7369));
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
  proc_update_salary(7369); -- will increase 8000 by 5% -> 8400.00
END;
/

BEGIN
  DBMS_OUTPUT.PUT_LINE('After proc: ' || (SELECT TO_CHAR(sal) FROM emp WHERE empno = 7369));
EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Example call: function (returns new salary)
DECLARE
  v_new_sal NUMBER;
BEGIN
  v_new_sal := fn_calc_and_update_salary(7521); -- 12500 > 10000 -> 6% => 13250.00
  DBMS_OUTPUT.PUT_LINE('Function returned new salary for 7521 = ' || TO_CHAR(v_new_sal));
END;
/

-- Query to view table contents
SELECT empno, ename, sal FROM emp ORDER BY empno;
