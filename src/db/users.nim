import db_postgres
import common, ../crypto

proc checkLogin*(username, password: string): bool =
  let hashed = hash(password)
  var valid = false
  
  withDb:
    let q = db.getRow(sql"SELECT username FROM users WHERE username = ? AND password = ?", username, hashed)
    valid = q[0] == username

  valid
