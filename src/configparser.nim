import parsecfg, os, macros
import defaults
import types/config

var loadedConfig: TkConfig

proc getLoadedConfig*(): TkConfig =
  ## Returns the loaded config
  loadedConfig

proc initCfg*(filename: string) =
  ## Initializes the config file with default values
  
  var cfg = newConfig()

  expandMacros:
    for cat in defaultConfigTable:
      for pair in cat.pairs:
        let value = $getValue(pair)
        
        cfg.setSectionKey(cat.category, pair.key, value)

  loadedConfig = cfg
  cfg.writeConfig filename

proc loadCfg*(filename: string): bool =
  ## Tries to load the config file into memory
  ## If the file doesn't exist it creates it and fills it with default values
  
  if not fileExists(filename):
    initCfg(filename)
    return true
  else:
    loadedConfig = loadConfig(filename)
    return false

initCfg("nigger")
