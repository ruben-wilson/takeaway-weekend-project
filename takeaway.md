# {{Diary}} Multi-Class Planned Design Recipe

## 1. Describe the Problem

As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices.
 
_list of dishes + prices._

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.

_add dishes to 'basket'._

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.

_receipt to be outputted with total prices for dishes._

## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

```
                              ┌────────────────────────────────────────────────┐
                              │    Diary                                       │
                              │   add_entry(entry)                             │
                              │                                                │
                              │   add_task(task)                               │
                              │                                                │
                              │   all_entries                                  │
                              │      => [entries..]                            │
                              │   all_tasks                                    │
                              │      => [tasks...]                             │
                              │   find_entries_based_on_reading_speed(wpm,time)├───┐
                      ┌───────┤      => [entries..]                            │   │
                      │       │   all_phone_numbers                            │   │
                      │       │      => [numbers...]                           │   │
                      │       └────────────────────────────────────────────────┘   │
                      │                                                            │
                      │                                                            │
                      │                                           ┌────────────────▼┐
┌─────────────────────▼─────┐                                     │     Task        │
│    DiaryEntry             │                                     │ initalize(task) │
│  initalize(title,contents)│                                     │                 │
│                           │                                     │ task            │
│  title                    │                                     │  => task(string)│
│      => title             │                                     │                 │
│  contents                 │                                     │                 │
│      => contents          │                                     └─────────────────┘
│  word_count               │
│      =>self.word_count    │
│  find_phone_numbers       │
│      =>[phone_numbers...] │
└───────────────────────────┘


```

_Also design the interface of each class in more detail._

```ruby
class Diary
  def initalize
    # ...
  end 

  def add_entry(entry) #entry is a diary entry object
    # add entry to diaryentry array 
    # returns nothing
  end 

  def add_task(task) # task is a task object
    # returns nothing 
  end

  def all_entries
    # returns array of diary entries
  end

  def all_tasks
    # returns array of tasks 
  end

  def find_entries_based_on_reading_speed(wpm, minutes)
    # returns array of entries with word count matching or under wpm * minutes
  end

  def all_phone_numbers
    # returns an array of numbers
  end
end

class DiaryEntry
  def initialize(title, contents) # title and contents are strings
    # ...
  end

  def title
    # returns the title
  end

  def contents
    # returns the contents
  end

  def word_count
    # returns the word count of contents
  end

  def find_phone_numbers
    # returns phone numbers written in contents as an array
  end
end

class Task
  def initialize(task) # task is a string
    # ...
  end

  def task
    # returns the task
  end
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# add diary entry
diary = Diary.new
diary_entry_1 = DiaryEntry.new("Monday", "went to shops")
diary.add_entry(diary_entry_1)
diary.all_entries # => [diary_entry_1]

# add task
diary = Diary.new
task_1 = Task.new("get lunch")
diary.add_task(task_1)
diary.all_task # => [task_1]

# add entry and task
diary = Diary.new
diary_entry_1 = DiaryEntry.new("Monday", "went to shops")
diary.add_entry(diary_entry_1)
task_1 = Task.new("get lunch")
diary.add_task(task_1)
diary.all_entries # => [diary_entry_1]
diary.all_tasks # => [task_1]

# find entries based on reading speed
diary = Diary.new
diary_entry_1 = DiaryEntry.new("Monday", "one " * 200)
diary_entry_2 = DiaryEntry.new("Tuesday", "two " * 400)
diary.add_entry(diary_entry_1)
diary.add_entry(diary_entry_2)
diary.find_entries_based_on_reading_speed(200, 1) # => [diary_entry_1]
diary.find_entries_based_on_reading_speed(400, 1) # => [diary_entry_2]

# return phone numbers from entries
diary = Diary.new
diary_entry_1 = DiaryEntry.new("Monday", "my friend Dave - 07777000000")
diary_entry_2 = DiaryEntry.new("Tuesday", "Sarah is great - 07983525525")
diary_entry_3 = DiaryEntry.new("Wednesday", "went swimming")
diary.add_entry(diary_entry_1)
diary.add_entry(diary_entry_2)
diary.add_entry(diary_entry_3)
diary.all_phone_numbers # => ["07777000000", "07983525525"]

# no duplicate phone numbers
diary = Diary.new
diary_entry_1 = DiaryEntry.new("Monday", "my friend Dave - 07777000000")
diary_entry_2 = DiaryEntry.new("Tuesday", "Sarah is great - 07777000000")
diary.add_entry(diary_entry_1)
diary.add_entry(diary_entry_2)
diary.all_phone_numbers # => ["07777000000"]

# multiple numbers in entry returned within flattened array
diary = Diary.new
diary_entry_1 = DiaryEntry.new("Monday", "my friend Dave - 07777000000, and Brian - 07900000000")
diary_entry_2 = DiaryEntry.new("Tuesday", "Sarah is great - 07600000000")
diary.add_entry(diary_entry_1)
diary.add_entry(diary_entry_2)
diary.all_phone_numbers # => ["07777000000", "07900000000", "07600000000"]

# should fail if wpm or minutes are not integers above 0
diary = Diary.new
diary_entry_1 = DiaryEntry.new("Monday", "my friend Dave - 07777000000")
diary_entry_2 = DiaryEntry.new("Tuesday", "Sarah is great - 07600000000")
diary.find_entries_based_on_reading_speed(0, 1) # throws an exception "values must be integers greater than 0"
diary.find_entries_based_on_reading_speed(true, 1) # throws an exception "values must be integers greater than 0"
diary.find_entries_based_on_reading_speed(0, 0) # throws an exception "values must be integers greater than 0"
diary.find_entries_based_on_reading_speed("200", [0]) # throws an exception "values must be integers greater than 0"
```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# EXAMPLE
#diary 
diary = Diary.new
diary.add_entry("string") # throws an exception "entries must be diary entry objects"
diary.add_task("string")# throws an exception  "entries must be diary entry objects"

#DiaryEntries
#test for edge cases when initalizing DiaryEntries
entry = DiaryEntry.new(2,[])# throws an exception "entries must be a string"

#when title is called returns title as string 
entry = DiaryEntry.new("title", "contents")
entry.title # => "title"
entry.contents# => "contents"

#when word_count is called returns word count for @contents
entry = DiaryEntry.new("title", "contents")
entry.word_count #=> 1

#returns any numbers within @contents string 
entry = DiaryEntry.new("title", "contents 07600000000")
entry.find_phone_numbers #=>  ["07600000000"]

#returns multiply numbers within an array
entry = DiaryEntry.new("title", "contents 07600000000, 07600000001")
entry.find_phone_numbers #=>  ["07600000000", "07600000001"]

#doesn't return numbers that arnt phone number format
# ie must ither 07  at start and must be 11 digits long 
entry = DiaryEntry.new("title", "contents 97600000000, 076000")
entry.find_phone_numbers #=>  []



# Constructs a track
track = Track.new("Carte Blanche", "Veracocha")
track.title # => "Carte Blanche"

#task 
# test task only initalizes with string 
task = Task.new(true) # expect to throw exception "task must be string"
task = Task.new(1) # expect to throw exception "task must be string"


#task method returns @task as string 
task = Task.new("string")
task.task #=> "string"
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._


<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
