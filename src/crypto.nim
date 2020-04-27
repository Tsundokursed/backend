import strutils
import nimcrypto/pbkdf2, nimcrypto/hmac

when not isMainModule:
  # only import the config parser when it's used as a library so that it doesn't generate
  # the default config file unnecessarily
  import configparser

template toOpenArray*(str: string): untyped =
  str.toOpenArray(0, str.high)

proc hash*(str: string): string =
  var
    salt: string
    hmacKey: string
    hashIter: int

  when isMainModule:
    salt = paramStr(1)
    hmacKey = paramStr(2)
    hashIter = parseInt( paramStr(3) )
  else:
    salt = string.cfg("security", "salt")
    hmacKey = string.cfg("security", "secret")
    hashIter = int.cfg("security", "hashIter")
  
  var
    ctxHmac: HMAC[sha512]
    hash: array[128, byte]
    hashResult: int
  
  hashResult = pbkdf2(ctxHmac,
                      hmacKey.toOpenArray,
                      salt.toOpenArray,
                      hashIter,
                      hash)

  for b in hash:
    result.add b.toHex()

when isMainModule:
  if paramCount() != 4:
    stderr.write "Invalid amount of arguments, need 4\n./crypto salt hmacKey hashIter str\n"
    quit(1)

  stdout.write hash(paramStr(4))
