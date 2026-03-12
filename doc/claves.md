# Generar claves privada/publicas

## Code

```bash
# Clave privada
openssl genrsa -out certs/dev/jwt/jwt_private.pem 2048
# Clave pública
openssl rsa -in certs/dev/jwt/jwt_private.pem -pubout -out certs/dev/jwt/jwt_public.pem
```
