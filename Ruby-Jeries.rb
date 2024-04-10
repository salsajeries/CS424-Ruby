=begin
  Assignment: Ruby Program
  Course: CS 424-02
  Instructor: Professor Harry Delugach

  Student: Salwa Jeries
  Date: April 9, 2024

  Summary:
    This program reads in a "register.txt" file containing information about athletes and events, processes
    the relationships between them, then outputs the following information:
    
      - Each athlete's name, and the events they are participating in
      - Each event's title, and the athletes that are participating in it
    
    For the program design, I created an "Athlete" class containing their ID, name, and a list of corresponding
    event IDs to the events they were participating in. I also created an "Event" class containing its ID, title,
    and a list of corresponding athlete IDs to the athletes participating in the event. Within these classes, I
    had the generally expected initializer, getter, and setter functions for the instance variables.

    The final two classes I made were the "AthleteList" and "EventList" classes, which contained lists for their
    respective class objects as well as some special functions. These two classes made managing all the athlete
    and event objects much easier. I also added some search functions that would find specific athlete or event
    objects by ID from the lists in the class. 

    Since the input file was divided into three sections, I created three different file read sections to handle
    the sets of data properly. The first section initialized each "Athlete" in the "AthleteList" object, while the
    second section initialized each "Event" in the "EventList" object. The third section would search for the
    "Athlete" object with a matching ID to the file read in the "AthleteList" object and assign it to the "Event"
    object with a matching ID to the file read in the "EventList" object. Similarly, it would assign the "Event"
    object with a matching ID to the file read in the "EventList" object to the "Athlete" object with a matching
    ID to the file read in the "AthleteList" object.

=end

# Athlete Class
class Athlete
  # Instance variables
  @athlete_id = ""
  @name = ""
  @event_ids = []

  # Initialize athlete object instance
  def initialize(id, name)
    @athlete_id = id
    @name = name
    @event_ids = []
  end

  # Add event ID to array
  def add_event_id(event_id)
    @event_ids.push(event_id)
  end

  # Get all event IDs in array
  def get_all_event_ids()
    return @event_ids
  end

  # Get athlete ID
  def get_athlete_id()
    return @athlete_id
  end

  # Get athlete name
  def get_athlete_name()
    return @name
  end
end

# Event Class
class Event
  # Instance variables
  @event_id = ""
  @title = ""
  @athlete_ids = []

  # Initialize event object instance
  def initialize(event_id, title)
    @event_id = event_id
    @title = title
    @athlete_ids = []
  end

  # Add athlete ID to array
  def add_athlete_id(athlete_id)
    @athlete_ids.push(athlete_id)
  end

  # Get all athlete IDs in array
  def get_all_athlete_ids()
    return @athlete_ids
  end

  # Get event ID
  def get_event_id()
    return @event_id
  end

  # Get event title
  def get_event_title()
    return @title
  end

end

# Athlete List Class
class AthleteList
  # Instance variables
  @list = []

  # Initialize athlete list object instance
  def initialize()
    @list = []
  end

  # Add athlete to list
  def add_athlete(athlete)
    @list.push(athlete)
  end

  # Get athlete by ID
  def get_athlete_by_id(athlete_id)
    @list.each do |athlete|
      if athlete.get_athlete_id == athlete_id
        return athlete
      end
    end
  end

  # Get list of athletes
  def get_list()
    return @list
  end
end

# Event List Class
class EventList
  # Instance variables
  @list = []

  # Initialize event list object instance
  def initialize()
    @list = []
  end

  # Add event to list
  def add_event(event)
    @list.push(event)
  end

  # Get event by ID
  def get_event_by_id(event_id)
    @list.each do |event|
      if event.get_event_id == event_id
        return event
      end
    end
  end

  # Get list of events
  def get_list()
    return @list
  end
end

file = File.open("register.txt")  # Open file
lines = file.read.split(pattern="\n") # Split each line to be element in array

# Athlete & event lists
all_athletes = AthleteList.new()
all_events = EventList.new()

# Loop for first section:
# Athlete ID, Athlete Name
lines.each_with_index do |line, index|
  # If line is empty, new section
  if line.strip.empty?
    lines = lines[index+1...]
    break # Exit loop for first section
  else
    items = line.split(" ", 2)  # Split into Athlete ID & Athlete Name
    all_athletes.add_athlete(Athlete.new(items.first.strip, items.last.strip))
  end
end

# Loop for second section:
# Event ID, Event Title
lines.each_with_index do |line, index|
  # If line is empty, new section
  if line.strip.empty?
    lines = lines[index+1...]
    break # Exit loop for first section
  else
    items = line.split(" ", 2)  # Split into Event ID & Event Title
    all_events.add_event(Event.new(items.first.strip, items.last.strip))
  end
end

# Loop for third section:
# Athlete ID, Event ID
lines.each do |line|
  items = line.split(" ", 2)  # Split into Athlete ID & Event ID
  # Add event ID to athlete object
  all_athletes.get_athlete_by_id(items.first.strip).add_event_id(items.last.strip)
  # Add athlete ID to event object
  all_events.get_event_by_id(items.last.strip).add_athlete_id(items.first.strip)
end

# Print each athlete name and corresponding event titles
puts "-------------------------"
puts "ATHLETE LIST"
puts "-------------------------"
all_athletes.get_list().each do |athlete|
  # Print athlete name
  puts athlete.get_athlete_name
  puts "\s Events:"

  athlete.get_all_event_ids().each_with_index do |id, index|
    # Print event title, numbered
    title = all_events.get_event_by_id(id).get_event_title()
    puts "\s #{index + 1}. #{title}"
  end
  puts "\n"
end

# Print each event title and corresponding athlete names
puts "-------------------------"
puts "EVENT LIST"
puts "-------------------------"
all_events.get_list().each do |event|
  # Print event title
  puts event.get_event_title()
  puts "\s Participants:"

  event.get_all_athlete_ids().each_with_index do |id, index|
    # Print athlete name, numbered
    name = all_athletes.get_athlete_by_id(id).get_athlete_name()
    puts "\s #{index + 1}. #{name}"
  end
  puts "\n"
end

=begin
  Thoughts and Impressions:
    Overall, I found Ruby to be relatively easy to pickup. It follows a similar style to Python by using
    implicit types, a lack of semicolons as end of line markers, and the option to use "print" for
    outputting data to the console. It does require "end" markers to signal the close of a "code block"
    scope, even though it does not require a starting marker or curly braces to encapsulate it. I find
    this to be a nice balance between Python's enforced indentation style and the typical curly brace
    markers of Java, C++, etc. I also found the ".each" range loops very interesting, and similar to
    the "map" method in Javascript/Typescript. Because I work mostly in Typescript, I found this
    extremely intuitive.
=end
