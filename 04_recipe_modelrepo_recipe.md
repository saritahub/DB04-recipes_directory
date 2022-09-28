# Albums Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `albums`*

```
# EXAMPLE

| Record | Properties                 |
|--------|----------------------------|
| recipe | name, cooking_time, rating |

Name of the table (always plural): `recipes`

Column names: `name`, `cooking_time`, `rating`
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_recipes.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, cooking_time, rating) VALUES ('Sandwich', 3, 4);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Pasta', 15, 4);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Pizza', 30, 5);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 recipe_directory_test < /Users/saritaradia/Desktop/Projects/recipes_directory/spec/seeds_recipes.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/recipedirectory.rb)
class RecipeDirectory
end

# Repository class
# (in lib/recipedirectory_repository.rb)
class RecipeDirectoryRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipe.rb)

class RecipeDirectory

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cooking_time, :rating
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# recipe = RecipeDirectory.new
# album[0].name = 'Sandwich'

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: recipes

# Repository class
# (in lib/RecipeDirectory_repository.rb)

class RecipeDirectoryRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, cooking_time, rating FROM recipes;

    # Returns an array of RecipeDirectory objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, title, cooking_time, rating FROM recipes WHERE id = $1;

    # Returns a single RecipeDirectory object.
  end
  
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all albums from the TESTS
# NOT THE REAL DATA!
    repo = RecipeDirectoryRepository.new 
    recipe = repo.all 
    expect(recipe.length).to eq(3)
    expect(recipe[0].id).to eq('1')
    expect(recipe[0].name).to eq('Sandwich')
    expect(recipe[0].cooking_time).to eq('3')
    expect(recipe[0].rating).to eq('4')

#2 Test real data
# Get all recipes where there are no recipes in the database
    repo = RecipeDirectoryRepository.new
    recipe = repo.all 
    expect(recipe).to eq []

#3 Get a single album ('Sandwich')
repo = RecipeDirectoryRepository.new
recipe = repo.find(1)
expect(recipe.name).to eq('Sandwich')
expect(recipe.cooking_time).to eq('3')
expect(recipe.rating).to eq('4')







# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_recipe_table
  seed_sql = File.read('spec/recipe_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipe' })
  connection.exec(seed_sql)
end

describe RecipeDirectoryRepository do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._