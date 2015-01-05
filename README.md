tmpl [![Dependency Status](https://david-dm.org/e-jigsaw/tmpl.svg)](https://david-dm.org/e-jigsaw/tmpl)
====

scaffold generator

# Usage

```
✈ tmpl
? Select template: github-pages
? name: sample
? description: sample page
mkdir: src
create: README.md
create: package.json
create: src/index.jade
create: .gitignore
create: gulpfile.coffee
create: src/index.coffee
create: src/index.styl
```

# Installation

```
% npm install -g e-jigsaw/tmpl
```

# Requirements

* Node.js(latest recommended)
* CoffeeScript

# How to make new Tmpl

1. Create directory in `Tmpls`
2. Write `generator.coffee`
3. Make some templates in `tmpl`

## Sample

```
✈ tree Tmpls/github-pages
.
├── generator.coffee
└── tmpl
    ├── README.md.hbs
    ├── _gitignore
    ├── gulpfile.coffee
    ├── package.json.hbs
    └── src
        ├── index.coffee
        ├── index.jade.hbs
        └── index.styl
```

`generator.coffee`:

```
exports.questions = [
  {
    type: 'input'
    name: 'name'
    message: 'name'
    default: process.cwd().split('/')[process.cwd().split('/').length-1]
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
  @template 'src/index.jade',
    name: answers.name
  @copy '_gitignore', '.gitignore'
  @copy 'gulpfile.coffee'
  @copy 'src/index.coffee'
  @copy 'src/index.styl'
```

`generator.coffee` must have `questions` and `actions`. `questions` are [`Inquirer.js#objects`](https://github.com/SBoudrias/Inquirer.js#objects). `actions` has some methods. See below.

### `actions` methods

* `mkdir(dest)`
  * Create directory
  * `dist`(`String`) is directory name
* `template(filename, data, dest)`
  * [handlebars](https://github.com/wycats/handlebars.js/) template generate
  * `filename`(`String`) is a filename. It reference to `tmpl/filename.hbs`.
  * `data`(`Object`) is a template contents.
  * `dest`(`String`, Optional) is a filename.
* `copy(dist, dest)`
  * Copy file
  * `dist`(`String`) is a filename. It reference to `tmpl/dist`.
  * `dest`(`String`, Optional) is a filename too. `dist` copied to `dest`. It can omit.

# Author

* jigsaw (http://jgs.me, [@e-jigsaw](https://github.com/e-jigsaw))

# License

MIT

The MIT License (MIT)

Copyright (c) 2015 Takaya Kobayashi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
