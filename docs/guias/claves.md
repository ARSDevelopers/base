# Generar claves privada/publicas

## Code

```bash
# Clave privada
openssl genrsa -out config/certs/dev/jwt/jwt_private.pem 2048
# Clave pública
openssl rsa -in config/certs/dev/jwt/jwt_private.pem -pubout -out config/certs/dev/jwt/jwt_public.pem
```
