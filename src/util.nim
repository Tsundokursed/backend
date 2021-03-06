import elvis

template has*(key: string): bool =
  ## Returns wheter request.formData has the `key` key
  ?request.formData[key].body

template get*(key: string): string =
  request.formData[key].body
  
template need*(key: string) =
  ## Returns Http400 if the specified key not set in formData
  if not has key:
    resp Http400, key & " field not set\n"

proc toSeq*(str: string): seq[char] =
  for c in str:
    result.add(c)
  
