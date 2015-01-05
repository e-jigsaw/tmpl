exports.questions = [
  {
    type: 'input'
    name: 'title'
    message: 'title'
  }
  {
    type: 'input'
    name: 'url'
    message: 'url'
  }
]

exports.actions = (answers)->
  {title, url} = answers

  today = new Date()
  year = today.getFullYear()
  month = today.getMonth() + 1
  day = today.getDate()
  if month.toString().length is 1 then month = "0#{month}"
  if day.toString().length is 1 then day = "0#{day}"

  @template 'article.md',
    title: title
    url: "/#{year}-#{month}-#{day}-#{url}.html"
  , "posts/#{year}-#{month}-#{day}-#{url}.md"
