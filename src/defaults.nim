const defaultCfgFile* = "config.ini"

const defaultConfigTable*: seq[ tuple[category: string, pairs: seq[ tuple[key: string, value: string] ] ] ] = @[
  ("general", @[
    ("port", "5000"),
    ("bindAddress", "0.0.0.0"),
    ("appName", ""),
    ("defaultUriScheme", "https")
  ]),
  ("auth", @[
    ("salt", ""),
    ("expiryDays", "1")
  ])
]
