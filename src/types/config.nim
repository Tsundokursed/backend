import options, macros
import ../typeutil

# (key: "port", value: (kind: TkInt, intVal: 5000))

type
  TkConfigKind = enum
    TkInt, TkBool, TkFloat, TkStr
  TkConfigVal = object
    case kind*: TkConfigKind
    of TkInt:   intVal: int
    of TkBool:  boolVal: bool
    of TkFloat: floatVal: float
    of TkStr:   strVal: string
    
  TkShortcut = tuple[category: string, key: string]
  TkConfigPair* =
    tuple[key: string, value: TkConfigVal]
  TkConfigCategory* =
    tuple[category: string, pairs: seq[TkConfigPair]]
  TkConfig* = seq[TkConfigCategory]

# ---------------------------------
# Procs to create new config values
# ---------------------------------

proc newTkInt*(val: int): TkConfigVal =
  result.kind = TkInt
  result.intVal = val

proc newTkBool*(val: bool): TkConfigVal =
  result.kind = TkBool
  result.boolVal = val

proc newTkFloat*(val: float): TkConfigVal =
  result.kind = TkFloat
  result.floatVal = val

proc newTkStr*(val: string): TkConfigVal =
  result.kind = TkStr
  result.strVal = val

# ------------------------------------------
# Procs to retrieve data from TkConfig types
# ------------------------------------------  
  
template getType*(pair: TkConfigPair): untyped =
  ## Returns the type of a `TkConfigPair`
  case pair.value.kind
  of TkInt:   int
  of TkBool:  bool
  of TkFloat: float
  of TkStr:   string

proc getValue*(T: typedesc, pair: TkConfigPair): T =
  case pair.value.kind
  of TkInt:   pair.value.intVal
  of TkBool:  pair.value.boolVal
  of TkFloat: pair.value.floatVal
  of TkStr:   pair.value.strVal

  
proc getStrValue*(pair: TkConfigPair): string =
  return $getValue(getType(pair), pair)
  
proc getCategory*(config: TkConfig, category: string): Option[TkConfigCategory] =
  for c in config:
    if c.category == category:
      return some c

  none TkConfigCategory

proc getPair*(category: TkConfigCategory, pairKey: string): Option[TkConfigPair] =
  for pair in category.pairs:
    if pair.key == pairKey:
      return some pair

  none TkConfigPair
  
proc getPair*(config: TkConfig, category: string, pairKey: string): Option[TkConfigPair] =
  let category = config.getCategory(category)

  if category.isNone:
    return none TkConfigPair
  
  getPair(category.get, pairKey)
  
proc cfg*(T: typedesc, config: TkConfig, category: string, key: string): T =
  let pair = config.getPair(category, key)

  if pair.isNone:
    return T.defaultValue

  parseValue(getType pair.get, getValue(pair.get))
