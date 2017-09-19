require ('sinatra')
require ('sinatra/reloader')
also_reload('.lib/**/*.rb')
require ('./lib/list')
require ('./lib/task')
require ('pry')
require ('pg')


DB = PG.connect({:dbname => 'todo'})

get('/') do
  @lists = List.all()
  erb(:index)
end

post('/') do
  list_name = params.fetch("list")
  lists_obj = List.new({:name => list_name})
  lists_obj.save()
  @lists = List.all()
  erb(:index)
end

get ('/task/:id') do
  @id = params.fetch(:id)
  @name =List.find_name(@id);
  @tasks = Task.find_all_details(@id)
  erb(:lists_task)
end

post('/task/:id') do
  @id = params.fetch(:id)
  description = params.fetch("task")
  due_date = params.fetch("date")
  task = Task.new({:description => description, :due_date => due_date, :unique_id => @id})
  task.save()
  @tasks = Task.find_all_details(@id)
  @name =List.find_name(@id);
  erb(:lists_task)
end
