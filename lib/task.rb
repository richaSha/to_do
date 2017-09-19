class Task
  attr_reader :id
  attr_accessor :description, :due_date, :unique_id
  def initialize (attribute)
    @description = attribute.fetch(:description)
    @due_date = attribute.fetch(:due_date)
    @unique_id = attribute.fetch(:unique_id)
  end

  def save
    DB.exec("INSERT INTO tasks (description, due_date, unique_id ) VALUES
    ('#{description}', '#{due_date}' , #{unique_id.to_i});");
  end

  def self.find_all_details(id)
    tasks_db = DB.exec("SELECT * FROM tasks WHERE unique_id = #{id.to_i};")
    tasks = []
    tasks_db.each do |task|
      description = task.fetch('description')
      due_date = task.fetch('due_date')
      unique_id = task.fetch('unique_id')
      tasks.push(Task.new({:description => description, :due_date => due_date, :unique_id => unique_id}))
    end
    tasks
  end

  def ==(another_object)
    (self.description .== another_object.description) .& (self.description .== another_object.description)
  end
end
