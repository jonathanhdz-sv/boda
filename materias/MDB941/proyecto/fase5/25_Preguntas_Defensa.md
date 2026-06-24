# 25 Posibles Preguntas de Defensa — Fase 5: Mantenimiento de Datos
## Proyecto ExperienciaSV | Jonathan Hernández HG235460

---

### BACKUPS (Preguntas 1-7)

**1. ¿Qué es un backup y para qué sirve?**
Es una copia de seguridad de la base de datos guardada en otro lugar. Sirve para restaurar los datos si el archivo original se corrompe, se borra por error o falla el disco duro. Sin backups, ante un desastre se pierde todo.

**2. ¿Qué diferencia hay entre backup FULL, DIFERENCIAL y TRANSACTION LOG?**
- **FULL:** copia toda la base de datos. Es pesado, se hace 1 vez al día.
- **DIFERENCIAL:** copia solo lo que cambió desde el último FULL. Más liviano, cada 6 horas.
- **LOG:** copia el historial de cada operación (INSERT, UPDATE, DELETE). Permite restaurar al minuto exacto. Cada 1 hora.

**3. ¿Cómo se restaura después de un desastre?**
Se restaura el FULL más reciente, luego el último DIFERENCIAL, y después todos los LOG posteriores en orden. Con esto se recuperan los datos hasta 1 hora antes del fallo.

**4. ¿Para qué sirve la opción COMPRESSION en un backup?**
Reduce el tamaño del archivo de backup hasta un 70%. Sin ella, el backup ocupa más espacio en disco.

**5. ¿Para qué sirve CHECKSUM en un backup?**
Verifica que los datos del backup no estén corruptos. Si no se usa, no sabés si el backup sirve hasta que intentás restaurarlo y falla.

**6. ¿Cómo verificás que un backup no está corrupto?**
Con `RESTORE VERIFYONLY FROM DISK = 'ruta' WITH CHECKSUM;`. Si responde "The backup set is valid", está sano.

**7. ¿Por qué los backups se hacen de madrugada?**
Porque son tareas pesadas que consumen recursos del servidor. En la madrugada hay poca o nula actividad de usuarios, entonces no se afecta el rendimiento en horas pico.

---

### ÍNDICES (Preguntas 8-12)

**8. ¿Qué es un índice en una base de datos?**
Es una estructura que acelera las búsquedas. Sin índice, SQL Server recorre fila por fila (table scan). Con índice, va directo a los datos, como buscar en el índice de un libro en vez de hojear todas las páginas.

**9. ¿Qué es la fragmentación de índices?**
Es el desorden que se produce en las páginas del índice cuando se insertan, actualizan y borran datos. Mientras más alto el porcentaje de fragmentación, más lentas son las consultas.

**10. ¿Cuándo usás REBUILD y cuándo REORGANIZE?**
- Fragmentación > 30%: **REBUILD** (borra el índice y lo crea desde cero, más pesado).
- Fragmentación entre 10% y 30%: **REORGANIZE** (reordena las páginas sin reconstruir, más liviano).
- Menos de 10%: no se toca.

**11. ¿Qué diferencia hay entre REBUILD y REORGANIZE?**
REBUILD bloquea la tabla mientras se ejecuta y es más pesado. REORGANIZE no bloquea (se puede usar la tabla mientras) y es más liviano. REBUILD es para casos graves (>30%), REORGANIZE para casos leves (10-30%).

**12. ¿Cómo sabés cuánta fragmentación tiene un índice?**
Consultando `sys.dm_db_index_physical_stats`. Esta vista del sistema devuelve el porcentaje de fragmentación de cada índice.

---

### ESTADÍSTICAS (Preguntas 13-15)

**13. ¿Qué son las estadísticas y para qué sirven?**
Son información que SQL Server recolecta sobre las tablas: cuántas filas tienen, cuántos valores distintos hay en cada columna, etc. El optimizador las usa para decidir el plan de ejecución más eficiente de cada consulta.

**14. ¿Qué pasa si las estadísticas están desactualizadas?**
El optimizador toma decisiones con información vieja. Por ejemplo, cree que una tabla tiene 100 filas cuando en realidad tiene 10,000. Usa un plan ineficiente y las consultas se vuelven lentas.

**15. ¿Cómo se actualizan las estadísticas?**
- Por tabla: `UPDATE STATISTICS nombre_tabla;`
- Toda la base de datos: `EXEC sp_updatestats;`

---

### LOGS Y SHRINK (Preguntas 16-18)

**16. ¿Cuáles son los dos archivos de una base de datos SQL Server?**
- **.mdf** (datos): guarda los datos reales (turistas, reservas, pagos).
- **.ldf** (log): guarda la bitácora de cada operación ejecutada.

**17. ¿Por qué crece el archivo .ldf?**
Porque guarda todas las sentencias SQL ejecutadas (INSERT, UPDATE, DELETE) y nunca se limpia solo. Si no se compacta, crece sin control.

**18. ¿Por qué el AUTO_SHRINK debe estar en OFF?**
Porque se dispara automáticamente en cualquier momento y causa fragmentación en los índices. Es mejor hacer SHRINK manualmente una vez por semana, después del REBUILD de índices.

---

### JOBS Y SQL SERVER AGENT (Preguntas 19-21)

**19. ¿Qué es un job en SQL Server?**
Es una tarea programada que se ejecuta automáticamente. Tiene 3 partes: un nombre, uno o más pasos (lo que hace) y un horario (cuándo se ejecuta). Los ejecuta el servicio SQL Server Agent.

**20. ¿Cuáles son los 5 pasos para crear un job?**
`sp_add_job` → `sp_add_jobstep` → `sp_add_schedule` → `sp_attach_schedule` → `sp_add_jobserver`. (Regla: job → step → schedule → attach → server)

**21. ¿Qué jobs creaste para ExperienciaSV y en qué horario?**
- Backup completo: diario 2:00 AM
- Mantenimiento de índices: domingo 3:00 AM
- Actualizar estadísticas: domingo 1:00 AM
- Compactar logs: domingo 4:00 AM

---

### DATABASE MAIL (Preguntas 22-23)

**22. ¿Qué es Database Mail y para qué sirve?**
Es el sistema de correo integrado en SQL Server. Permite que la base de datos envíe correos automáticos sin programas externos. Sirve para alertas (backup falló), reportes y notificaciones.

**23. ¿Cuáles son los pasos para configurarlo?**
Habilitar Agent XPs, crear un perfil, crear una cuenta SMTP, asociar la cuenta al perfil y enviar correo de prueba con `sp_send_dbmail`.

---

### GENERAL (Preguntas 24-25)

**24. ¿Por qué configurás el crecimiento de archivos en MB y no en porcentaje?**
Porque en MB el crecimiento es predecible (siempre 50 MB). Con porcentaje, un archivo de 10 GB crece 1 GB por evento, lo cual es excesivo y llena el disco rápidamente.

**25. ¿Qué recomendación das sobre la memoria RAM para SQL Server?**
Reservar al menos 20% de la RAM para el sistema operativo. Si la máquina tiene 8 GB, configurar SQL Server con máximo 6.4 GB (`sp_configure 'max server memory', 6144`). Así el sistema operativo no se queda sin recursos.
