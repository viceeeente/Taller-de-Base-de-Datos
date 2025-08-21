DECLARE
    CURSOR c_marca IS
    SELECT
        id_marca,
        nombre_marca
    FROM
        marca;

    CURSOR c_camion (
        p_id_marca NUMBER
    ) IS
    SELECT
        nro_patente,
        anio,
        valor_arriendo_dia
    FROM
        camion
    WHERE
        id_marca = p_id_marca;

    v_camiones_marca NUMBER;
    v_contador       NUMBER := 0;
BEGIN
    FOR r_marca IN c_marca LOOP
        SELECT
            COUNT(*)
        INTO v_camiones_marca
        FROM
            camion
        WHERE
            id_marca = r_marca.id_marca;

        dbms_output.put_line(r_marca.nombre_marca
                             || ' : '
                             || v_camiones_marca);
        FOR r_camion IN c_camion(r_marca.id_marca) LOOP
            v_contador := v_contador + 1;
            dbms_output.put_line(v_contador
                                 || '. Patente     : '
                                 || r_camion.nro_patente);
            dbms_output.put_line('   Año         : ' || r_camion.anio);
            dbms_output.put_line('   Arriendo Dia: '
                                 || to_char(r_camion.valor_arriendo_dia, 'fml999G999G999'));
            dbms_output.put_line('');
        END LOOP;

        dbms_output.put_line('------------------------');
    END LOOP;

    FOR r_marca IN c_marca LOOP
        SELECT
            COUNT(*)
        INTO v_camiones_marca
        FROM
            camion
        WHERE
            id_marca = r_marca.id_marca;

        dbms_output.put_line(r_marca.nombre_marca
                             || ' : '
                             || v_camiones_marca);
    END LOOP;

    dbms_output.put_line('Total : ' || v_contador);
END;