DECLARE
    v_bono_anios NUMBER(10);
    v_afp NUMBER(10);
    v_salud NUMBER(10);
    v_sueldo_total NUMBER(10);
    TYPE varray_bono IS VARRAY(2) OF NUMBER;
    varray_a varray_bono;
    
    CURSOR c_empleado IS
    SELECT 
        id_emp,
        numrun_emp||'-'||dvrun_emp as run,
        pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp as nombre_completo,
        direccion_emp as direccion,
        c.nombre_comuna as comuna,
        sueldo_base,
        trunc(MONTHS_BETWEEN(SYSDATE,fecha_contrato)/12) as anios_trabajo,
        tp.porc_descto_salud as salud,
        a.porc_descto_afp as afp
    
    FROM 
        empleado e
    INNER JOIN comuna c ON e.id_comuna = c.id_comuna
    INNER JOIN tipo_salud tp ON tp.cod_tipo_sal = e.cod_tipo_sal
    INNER JOIN afp a ON e.cod_afp = a.cod_afp
    order by 1;
BEGIN
    varray_a := varray_bono(50000,100000);
    
    EXECUTE IMMEDIATE('truncate table liquidacion_sueldo');
    
    FOR i in c_empleado LOOP
    v_bono_anios:= i.sueldo_base*(i.anios_trabajo / 100);
    v_afp:=i.sueldo_base*(i.afp / 100);
    v_salud:=i.sueldo_base*(i.salud / 100);
    
    IF i.sueldo_base < 1000000 THEN
        v_sueldo_total:= v_sueldo_total+varray_a(1);
    ELSE
        v_sueldo_total:= v_sueldo_total+varray_a(2);
    END IF;
    
    v_sueldo_total:=i.sueldo_base+v_bono_anios-v_salud-v_afp;
    
        dbms_output.put_line('');
        dbms_output.put_line('Run : '||i.run);
        dbms_output.put_line('Nombre Completo : '||i.nombre_completo);
        dbms_output.put_line('Direccion : '||i.direccion);
        dbms_output.put_line('Comuna : '||i.comuna);
        dbms_output.put_line('Sueldo Base : '||i.sueldo_base);
        dbms_output.put_line('Años de trabajo : '||i.anios_trabajo);
        dbms_output.put_line('Bono años de trabajo : '||v_bono_anios);
        dbms_output.put_line('Salud : '||v_salud);
        dbms_output.put_line('AFP : '||v_afp);
        dbms_output.put_line('Sueldo Total : '||v_sueldo_total);
        
    
    END LOOP;

END;
