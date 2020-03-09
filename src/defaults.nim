import types/config

const defaultConfigTable*: TkConfig = @[
  ("general", @[
    ("port", 5000.newTkInt),
    ("bindAddress", "0.0.0.0".newTkStr),
    ("appName", "".newTkStr),
    ("keySaltPrefix", "".newTkStr),
    ("keySaltSuffix", "".newTkStr),
    ("defaultUriScheme", "https".newTkStr)
  ])
]
