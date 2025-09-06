CREATE OR REPLACE FUNCTION fn_obtener_edad ( p_id_emp number
) RETURN number AS
    v_edad number;
BEGIN
    SELECT
        TRUNC(months_between(sysdate,fecha_nac) / 12)
    into v_edad
    FROM
        empleado
    where id_emp = p_id_emp;
    return v_edad;
END;