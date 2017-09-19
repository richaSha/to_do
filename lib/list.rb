class List
  attr_reader :id
  attr_accessor :name
  def initialize (attribute)
    @name = attribute.fetch(:name)
    @id = (attribute.key?(:id) ? attribute.fetch(:id) : nil)
  end

  def save
    @id = DB.exec("INSERT INTO lists (name) VALUES
    ('#{name}') RETURNING id;");
  end

  def self.all
    tasks_db = DB.exec("SELECT * FROM lists;")
    tasks = []
    tasks_db.each do |task|
      name = task.fetch('name')
      id = task.fetch('id')
      tasks.push(List.new({:name => name, :id => id}))
    end
    tasks
  end

  def self.find_name(id)
    name = DB.exec("SELECT name FROM lists WHERE id = #{id.to_i};");
    name[0]['name']
  end

  def ==(another_object)
    self.name .== another_object.name
  end
end
