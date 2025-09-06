CREATE OR REPLACE FUNCTION fn_obtener_sueldo ( p_id_emp number
) RETURN number AS
    v_sueldo number;
BEGIN
    SELECT
        sueldo_base
    into v_sueldo
    FROM
        empleado
    where id_emp = p_id_emp;
    return v_sueldo;
END;