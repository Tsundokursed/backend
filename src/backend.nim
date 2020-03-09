import jester

router backendRouter:
  get "/":
    resp "It's alive!"

proc main() =
  let port = paramStr(1).parseInt().Port
  let settings = newSettings(port=port)
  var jester = initJester(myrouter, settings=settings)
  jester.serve()
  
when isMainModule:
  main()
