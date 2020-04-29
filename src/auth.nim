import times, json, tables
import configparser
import jwt

type
  AuthToken* = distinct string

proc signToken*(username: string): AuthToken =
  let
    time = getTime() + int.cfg("auth", "expiryDays").days
    epoch = time.toUnix
  
  var token = toJWT(%*{
    "header": {
      "alg": "HS256",
      "typ": "JWT"
    },
    "claims": {
      "user": username,
      "exp": epoch
    }
  })

  token.sign(string.cfg("auth", "salt"))

  return AuthToken($token)

proc verifyToken*(token: AuthToken): bool =
  try:
    let jwtToken = string(token).toJWT()
    result = jwtToken.verify(string.cfg("auth", "salt"))
  except:
    result = false

proc getUsername*(token: AuthToken): string =
  let jwt = string(token).toJWT()
  result = $jwt.claims["user"].node.str
