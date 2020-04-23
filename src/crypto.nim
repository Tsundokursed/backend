import nimSHA2

proc hash*(str: string): string =
  var sha = initSHA[SHA512]()
  
  sha.update(str)

  return sha.final().toHex()


  
