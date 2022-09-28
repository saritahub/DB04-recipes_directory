require '/Users/saritaradia/Desktop/Projects/recipes_directory/lib/04_recipe.rb'

class RecipeDirectoryRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, name, cooking_time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])

    recipes = []

    result_set.each do |record|
      recipe = RecipeDirectory.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']
      recipes << recipe
    end
    return recipes
    # Returns an array of RecipeDirectory objects.
  end

  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    recipe = RecipeDirectory.new
    recipe.id = record['id']
    recipe.name = record['name']
    recipe.cooking_time = record['cooking_time']
    recipe.rating = record['rating']

    return recipe

    # Returns a single RecipeDirectory object.
  end

end