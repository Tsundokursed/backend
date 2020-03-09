import strutils

proc defaultValue*(T: typedesc): T =
  ## Returns the default value for `T` type
  ## Currently only supports int, string, float and bool
  
  case T
  of int: 0
  of string: ""
  of bool: false
  of float: 0.0

proc parseValue*(T: typedesc, value: string): T =
  ## Parses the string value into `T` type
  ## Currently only supports int, string, float and bool

  case T
  of int: parseInt value
  of string: value
  of bool: parseBool value
  of float: parseFloat value
