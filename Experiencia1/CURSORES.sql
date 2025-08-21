DECLARE
    v_contador NUMBER := 0;
    v_marca    VARCHAR2(20);
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
        valor_arriendo_dia as arriendo
    FROM
        camion
    WHERE
        id_marca = p_id_marca;
cursor c_m (p_marca NUMBER) is
select 
        count(c.id_marca) as count
from 
    camion c 
inner join marca m on m.id_marca = c.id_marca
where c.id_marca = p_marca;
BEGIN
    FOR r_marca IN c_marca LOOP
        
        dbms_output.put_line('-------------------------------');
        for r_c_m in c_m(r_marca.id_marca) loop
            dbms_output.put_line(r_marca.nombre_marca||': '||r_c_m.count);
        end loop;
        FOR r_camion IN c_camion(r_marca.id_marca) LOOP
            v_contador := v_contador + 1;
            dbms_output.put_line(v_contador||'. Patente: ' || r_camion.nro_patente);
            dbms_output.put_line('Año: ' || r_camion.anio);
            dbms_output.put_line('Arriendo por Día: ' || r_camion.arriendo);
            dbms_output.put_line('');
        END LOOP;
    END LOOP;
    dbms_output.put_line('-------------------------------');
    dbms_output.put_line('');
    dbms_output.put_line('---TOTALES---');
    for r_marca in c_marca loop
        for r_c_m in c_m(r_marca.id_marca) loop
                dbms_output.put_line(''||r_marca.nombre_marca||': '||r_c_m.count);
            end loop;
    end loop;
    dbms_output.put_line('Total Camiones: '||v_contador);
    dbms_output.put_line(''||v_marca);
END;

