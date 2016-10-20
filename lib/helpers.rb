module Events
  def events
    YAML::load_file('events.yml')
  end
end
