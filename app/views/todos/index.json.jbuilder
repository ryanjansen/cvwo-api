json.todos @todos do |todo|
  json.id todo.id
  json.title todo.title
  json.done todo.done
  json.category todo.category.title unless todo.category.nil?
  json.due_date todo.due_date
end