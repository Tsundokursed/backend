import times, json, tables
import configparser, db/users
import jwt

type
  AuthToken* = distinct string
  AuthError* = object of ValueError

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
  
proc getToken*(username, password: string): AuthToken =
  let valid = checkLogin(username, password)

  if not valid:
    raise newException(AuthError, "Invalid username or password")

  signToken(username)
