fs = require 'fs'
path = require 'path'
inquirer = require 'inquirer'
mkdir = require 'mkdirp'
HBS = require 'handlebars'

class Generator
  constructor: -> @cwdPath = process.cwd()

  run: ->
    inquirer.prompt
      type: 'rawlist'
      name: 'tmpl'
      message: 'Select template'
      choices: fs.readdirSync path.resolve(__dirname, 'Tmpls')
    , @generate.bind(@)

  generate: (answer)->
    @tmplPath = path.resolve __dirname, 'Tmpls', answer.tmpl
    tmpl = require path.resolve(@tmplPath, 'generator')
    inquirer.prompt tmpl.questions, tmpl.actions.bind(@)

  mkdir: (dest)-> mkdir.sync path.resolve(@cwdPath, dest)

  template: (file, data)->
    source = fs.readFileSync path.resolve(@tmplPath, 'tmpl', "#{file}.hbs")
    tmpl = HBS.compile source.toString()
    fs.writeFileSync path.resolve(@cwdPath, file), tmpl(data)

  copy: (src, dest)->
    if dest is undefined then dest = src
    rs = fs.createReadStream path.resolve(@tmplPath, 'tmpl', src)
    ws = fs.createWriteStream path.resolve(@cwdPath, dest)
    rs.pipe ws

module.exports = new Generator()
