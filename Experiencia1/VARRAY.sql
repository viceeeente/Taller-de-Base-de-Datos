DECLARE
    v_bono NUMBER(10);
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
        trunc(sueldo_base*(trunc(MONTHS_BETWEEN(SYSDATE,fecha_contrato)/12)/100)) as bono_annios_trabajo,
        trunc(sueldo_base*(tp.porc_descto_salud/100)) as salud,
        trunc(sueldo_base*(a.porc_descto_afp/100)) as afp,
        sueldo_base+trunc(sueldo_base*(trunc(MONTHS_BETWEEN(SYSDATE,fecha_contrato)/12)/100))-trunc(sueldo_base*(tp.porc_descto_salud/100))-trunc(sueldo_base*(a.porc_descto_afp/100)) as sueldo_total
    
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
    
    IF i.sueldo_base < 1000000 THEN
        i.sueldo_total:= i.sueldo_total+varray_a(1);
    ELSE
        i.sueldo_total:= i.sueldo_total+varray_a(2);
    END IF;
    
    i.sueldo_total:=i.sueldo_base+i.bono_annios_trabajo-i.afp-i.salud;
    
        dbms_output.put_line('');
        dbms_output.put_line('Run : '||i.run);
        dbms_output.put_line('Nombre Completo : '||i.nombre_completo);
        dbms_output.put_line('Direccion : '||i.direccion);
        dbms_output.put_line('Comuna : '||i.comuna);
        dbms_output.put_line('Sueldo Base : '||i.sueldo_base);
        dbms_output.put_line('Años de trabajo : '||i.anios_trabajo);
        dbms_output.put_line('Bono años de trabajo : '||i.bono_annios_trabajo);
        dbms_output.put_line('Salud : '||i.salud);
        dbms_output.put_line('AFP : '||i.afp);
        dbms_output.put_line('Sueldo Total : '||i.sueldo_total);
        
    
    END LOOP;

END;
