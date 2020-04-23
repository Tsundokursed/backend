import db_postgres, macros

macro withDb*(body: untyped): untyped =
  let dbIdent = ident"db"
  
  result = quote do:
    let `dbIdent` = open("localhost", "tsundo", "tsundo", "tsundo")
    `body`
    `dbIdent`.close()
