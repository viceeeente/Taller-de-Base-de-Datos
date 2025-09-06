
    SELECT
        fn_obtener_nombre(id_emp) AS NOMBRE,
        to_char(fn_obtener_sueldo(id_emp),'fml99g999g999') as SUELDO,
        fn_obtener_edad(id_emp) as EDAD,
        fn_obtener_bono(id_emp) as BONO,
        to_char(fn_obtener_sueldo_total(id_emp),'fml99g999g999') as "SUELDO TOTAL"
    FROM
        empleado;