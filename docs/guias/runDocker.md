# 1. Run docker

Se ha establecido **perfiles** para cada servicio (`odoo` / `spring`), por el momento.
Una vez que ya no ser requiera el servicio, se debe de para la red para utilizar la otra.

```bash
# para spring
docker compose --profile spring-stack up
# para odoo
docker compose --profile odoo-stack up
# para full-stack, levantar todos los contenedores
docker compose --profile full-stack up

```
