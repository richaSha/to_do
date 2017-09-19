require ('spec_helper')

describe('#todo') do
  describe('.all') do
    it('should show empty array if database is empty') do
      expect(List.all()).to(eq([]))
    end
  end

  describe('.all') do
    it('should store object data into database and show all data from database') do
      list_obj = List.new({:name => "cleaning", :id =>1})
      list_obj.save()
      expect(List.all()).to(eq([list_obj]))
    end
  end

  describe('.find_name') do
    it('should find name from lists table using id') do
      list_obj = List.new({:name => "cleaning"})
      list_obj.save()
      id = list_obj.id
      expect(List.find_name(id[0]['id'])).to(eq('cleaning'))
    end
  end
  
  describe('.find_all_details') do
    it('should save object and return all details matching with passed unique_id') do
      list_obj = List.new({:name => "cleaning"})
      list_obj.save()
      id = list_obj.id[0]['id']
      task = Task.new({:description => "Need to wash cloth", :due_date => "2017-04-01", :unique_id => id})
      task.save()
      expect(Task.find_all_details(id)).to(eq([task]))
    end
  end

end
