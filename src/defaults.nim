import types/config

const defaultConfigTable*: TkConfig = @[
  ("general", @[
    ("port", "5000"),
    ("bindAddress", "0.0.0.0"),
    ("appName", ""),
    ("keySaltPrefix", ""),
    ("keySaltSuffix", ""),
    ("defaultUriScheme", "https")
  ])
]
