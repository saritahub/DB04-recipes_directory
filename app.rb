require '/Users/saritaradia/Desktop/Projects/recipes_directory/lib/database_connection.rb'
require '/Users/saritaradia/Desktop/Projects/recipes_directory/lib/04_recipe.rb'
require '/Users/saritaradia/Desktop/Projects/recipes_directory/lib/04_reciperepository.rb'
# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipe_directory')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, name, cooking_time, rating FROM recipes;'
p result = DatabaseConnection.exec_params(sql, [])

result.each do |record|
  p record
end

#OUTPUT
# {"id"=>"1", "name"=>"Pizza", "cooking_time"=>"30", "rating"=>"5"}
# {"id"=>"2", "name"=>"Pasta", "cooking_time"=>"15", "rating"=>"4"}
# {"id"=>"3", "name"=>"Sandwich", "cooking_time"=>"3", "rating"=>"4"}


