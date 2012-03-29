# # walk 
fs = require 'fs'
module.exports = walk = (dir, done) ->
  results = []
  fs.readdir dir, (err, list) ->
    return done(err, []) if err
    pending = list.length
    return done(null, results) unless pending
    for name in list
      file = "#{dir}/#{name}"
      try 
        stat = fs.statSync file 
      catch err 
        stat = null
      if stat?.isDirectory()
        walk file, (err, res) -> 
          results.push name for name in res
          done(null, results) unless --pending
      else
        results.push file
        done(null, results) unless --pending
