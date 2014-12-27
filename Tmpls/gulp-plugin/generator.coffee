exports.questions = [
  {
    type: 'input'
    name: 'name'
    message: 'name'
  }
  {
    type: 'input'
    name: 'description'
    message: 'description'
  }
]

exports.actions = (answers)->
  @mkdir 'src'
  @template 'README.md',
    name: answers.name
    description: answers.description
    partition: answers.name.replace /./g, '='
  @template 'package.json',
    name: answers.name
    description: answers.description
  @copy '_gitignore', '.gitignore'
  @copy 'gulpfile.coffee'
  @copy 'src/index.coffee'
