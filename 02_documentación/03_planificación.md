# Plainficación

## Definición del proyecto

Un sistema de seguimiento del psicologo al paciente mientras está acudiento a sesiones de terapia.

A continuación se definen palabras claves para el proyecto:

- Registo: cuestionario que rellena el paciente con los datos pertinentes y que se envia al psicologo.

## Tecnologías usadas

- Frontend paciente - app móvil en Flutter
- Frontend psicologo - web en VUE3
- Backend - JAVA + Spring
- Registro y subscripciones - ODOO

## Hitos y entregables iniciales

Hemos definido 3 etapas de hitos de entrega

### Etapa 1 - minimo funcional de la aplicación

Esta estapa consiste en llegar a los siguientes requisitos mínimos

- El psicologo puede subscribirse y hacer el registro que tiene que poder ser verificado por el admin.
- El paciente rellena con éxito el registro, se guarda y sigue el flujo marcado para que el psicologo lo reciba en su frontend.
- Se analiza cada registo, se crea un historial de registros y unas estadísticas para cada paciente.
- El psicologo tiene la opción de que el paciente vea o no sus registros y estadísticas.
- El login se valida con JWT.

### Etapa 2 - añadir mejoras funcionales

- Comunicación correcta mediante psicologo y paciente a través de un chat interno.
- El psicologo puede personalizar el formulario de cada uno de los pacientes

### Etapa 3 - añadir valor añadido

- No se pueden enviar datos sensibles por el chat.
- Se incluye IA revisada por el psicologo para que el paciente pueda consultar información sobre el problema/trans más común que tiene.
