import parsecfg, os, tables
import defaults
import typeutil

var loadedConfig: Config

proc initCfg*(filename: string) =
  ## Initializes the config file with default values
  var cfg = newConfig()

  for cat in defaultConfigTable:
    for pair in cat.pairs:
      cfg.setSectionKey(cat.category, pair.key, pair.value)

  loadedConfig = cfg
  cfg.writeConfig filename

proc loadCfg*(filename: string): bool =
  ##[ Tries to load the config file into memory
      If the file doesn't exist it creates it and fills it with default values
      Returns true if it created a new config file ]##
  
  if not fileExists(filename):
    initCfg(filename)
    return true
  else:
    loadedConfig = loadConfig(filename)
    return false
    
proc cfg*(T: typedesc, category: string, key: string): T =
  if not loadedConfig.hasKey(category) or
     not loadedConfig[category].hasKey(key):
    return T.default
  
  T.parseValue( loadedConfig[category][key] )
