import times, json, tables
import configparser
import jwt

proc signToken*(username: string): string =
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

  $token

proc verifyToken*(token: string): bool =
  try:
    let jwtToken = token.toJWT()
    result = jwtToken.verify(string.cfg("auth", "salt"))
  except:
    result = false

proc getUsername*(token: string): string =
  let jwt = token.toJWT()
  result = $jwt.claims["user"].node.str
