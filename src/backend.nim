import jester, elvis
import util, configparser, defaults

router backendRouter:
  get "/":
    resp "frontend placeholder"
  post "/api/auth/?":
    need "username"
    need "password"
    
    resp Http200, "authenticated\n"

proc main() =
  discard loadCfg(defaultCfgFile)
  
  var jester = initJester(backendRouter)
  jester.serve()
  
when isMainModule:
  main()
