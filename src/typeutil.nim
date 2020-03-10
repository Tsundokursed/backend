import strutils

proc parseValue*(T: typedesc, value: string): T =
  ## Parses the string value into `T` type
  ## Currently only supports int, string, float and bool

  when T is int:
    return parseInt value
  elif T is string:
    return value
  elif T is bool:
    return parseBool value
  elif T is float:
    return parseFloat value
