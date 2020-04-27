import jester, elvis
import util, configparser, defaults, db/users

import routes/user

router apiv1:
  extend user, "/user"
  
  get "/":
    resp "route should be /api/v#/"
    
router tsundo:
  extend apiv1, "/api/v1"
  
  get "/":
    resp "frontend placeholder"

  #[
  post "/api/internal/auth/?":
    need "username"
    need "password"

    let valid = checkLogin(get("username"), get("password"))

    if valid:
      resp Http200, "authenticated\n"
    else:
      resp Http403, "no\n" ]#

proc main() =
  discard loadCfg(defaultCfgFile)
  
  var jester = initJester(tsundo)
  jester.serve()
  
when isMainModule:
  main()
