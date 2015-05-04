require! {
  minimist
  \../package.json : pack
  \./Generator
}

module.exports = ->
  argv = minimist process.argv.slice 2

  if argv.version or argv.v
    console.log pack.version
    process.exit!

  new Generator!.run!
