CREATE OR REPLACE FUNCTION FN_SUMAR RETURN NUMBER AS 
    v_numero1 NUMBER := 2;
    v_numero2 NUMBER := 2;
    v_suma NUMBER :=0;

BEGIN
    v_suma:= v_numero1 + v_numero2;
    return v_suma;
END FN_SUMAR;
