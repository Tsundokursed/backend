import jester

router user:
  get "/":
    resp Http200, "hi"
  post "/":
    resp Http200, "hello"

  error Http404:
    resp Http404, ":("
