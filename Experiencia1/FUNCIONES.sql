CREATE OR REPLACE FUNCTION fn_obtener_nombre ( p_id_emp number
) RETURN VARCHAR2 AS
    v_nombre varchar(50);
BEGIN
    SELECT
        pnombre_emp
        || ' '
        || appaterno_emp
    into v_nombre
    FROM
        empleado
    where id_emp = p_id_emp;
    return v_nombre;
END;