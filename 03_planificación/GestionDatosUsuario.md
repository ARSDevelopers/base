# Gestión de datos de usuario
## Registro
Registro por invitación del psicólogo

- El profesional genera un enlace o código único asociado a un alias
- El paciente solo entra si ha sido invitado

Inicio sesión paciente
- Introduce email y contraseña y acepta los términos
- Se envia una verificación de email
- Al paciente le aparece el alias en su app

## Recuperación de cuenta
A través del email, se envia la opción de cambiar contraseña.

## Persistencia de datos
Todas las interacciones con los registros y las sesiones se guardan en la BD.
Al renaudar la atención psicológoca o al cambiar de dispositivo al tener email + contraseña → backend devuelve user_id -> patient_id

## Flujo
| Paso 1 | Paso 2 | paso3 |
|------------| ----------- | ------------- |
| Psicólogo crea codigo de invitación con un alias -> | Paciente entra código -> | Backend crea el usuario y lo vincula -> |
| (Backend) Genera un *invite_code* | (Paciente) Crea credenciales - email y contraseña  | (Backend) Se crea patient_id  |
| Asociado a psychologist_id, estado, fecha | (BD) Se crea su cuenta user_id | (BD) Registro en table patients y vinculación patient_id <-> psychologist_id |