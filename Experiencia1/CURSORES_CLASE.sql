SELECT
        ar.id_camion,
        COUNT(ar.id_arriendo),
        m.nombre_marca AS marca,
        c.nro_patente as patente
    FROM
             arriendo_camion ar
        INNER JOIN camion c ON c.id_camion = ar.id_camion
        INNER JOIN marca  m ON m.id_marca = c.id_marca
    WHERE
        EXTRACT(YEAR FROM sysdate) = EXTRACT(YEAR FROM fecha_devolucion)
    GROUP BY
        ar.id_camion,
        m.nombre_marca,
        c.nro_patente;