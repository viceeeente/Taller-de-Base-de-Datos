CREATE OR REPLACE FUNCTION fn_obtener_sueldo_total ( p_id_emp number
) RETURN number AS
    v_sueldo_total number;
BEGIN
    SELECT
        round(fn_obtener_sueldo(id_emp)+(fn_obtener_sueldo(id_emp)*fn_obtener_bono(id_emp)))
    into v_sueldo_total
    FROM
        empleado
    where id_emp = p_id_emp;
    return v_sueldo_total;
END;