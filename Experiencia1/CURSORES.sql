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
        color
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
        
        dbms_output.put_line('Marca: ' || r_marca.nombre_marca);
        dbms_output.put_line('');
        FOR r_camion IN c_camion(r_marca.id_marca) LOOP
            v_contador := v_contador + 1;
            dbms_output.put_line('Patente: ' || r_camion.nro_patente);
            v_marca:= r_marca.nombre_marca;
        END LOOP;
        for r_c_m in c_m(r_marca.id_marca) loop
            dbms_output.put_line('Cantidad: '||r_c_m.count);
            
            
        end loop;
        dbms_output.put_line('-------------------------------');
        
    END LOOP;
    
    dbms_output.put_line('TOTALES');
    dbms_output.put_line('Total Camiones: '||v_contador);
    dbms_output.put_line(''||v_marca);
END;