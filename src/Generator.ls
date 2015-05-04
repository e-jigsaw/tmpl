require! {
  fs: {readdirSync, readFileSync, writeFileSync, createReadStream, createWriteStream}
  path: {resolve}
  inquirer
  mkdirp
  handlebars: {compile}
}

class Generator
  -> @cwdPath = process.cwd!

  run: -> inquirer.prompt do
    type: \rawlist
    name: \tmpl
    message: 'Select template'
    choices: readdirSync <| resolve __dirname, \../Tmpls
    @generate.bind @

  generate: (answer)->
    @tmplPath = resolve __dirname, \../Tmpls, answer.tmpl
    tmpl = require resolve @tmplPath, \generator
    inquirer.prompt do
      tmpl.questions
      tmpl.actions.bind @

  mkdir: (dest)->
    mkdirp.sync resolve @cwdPath, dest
    log \mkdir, dest

  template: (file, data, dest)->
    if dest is undefined then dest = file
    source = readFileSync resolve @tmplPath, \tmpl, "#{file}.hbs"
    tmpl = compile source.toString!
    writeFileSync do
      resolve @cwdPath, dest
      tmpl data
    log \create, dest

  copy: (src, dest)->
    if dest is undefined then dest = src
    rs = createReadStream resolve @tmplPath, \tmpl, src
    ws = createWriteStream resolve @cwdPath, dest
    rs.pipe ws
    log \create, dest

  log = (type, dest)-> console.log "#{type}: #{dest}"

module.exports = Generator
