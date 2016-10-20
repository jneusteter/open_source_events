class Event
  def initialize(command)
    @command = command
  end

  def array
    @command.gsub(' -', '-').split('-')
  end

  def id
    id = array.select { |id| id[0..1] == 'id' }[0]
    if id.nil?
      # nothing
    else
      id.gsub('id ', '')
    end
  end

  def name
    name = array.select { |name| name[0..3] == 'name' }[0]
    if name.nil?
      # nothing
    else
      name.gsub('name ', '')
    end
  end

  def starts
    starts = array.select { |starts| starts[0..5] == 'starts' }[0]
    if starts.nil?
      # nothing
    else
      Date.parse(starts.gsub('starts ', ''))
    end
  end

  def ends
    ends = array.select { |ends| ends[0..3] == 'ends' }[0]
    if ends.nil?
      # nothing
    else
      Date.parse(ends.gsub('ends', ''))
    end
  end

  def delete?
    array.include?('delete')
  end
end

def all_events
  DB[:events]
end
