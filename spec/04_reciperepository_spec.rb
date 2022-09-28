require '/Users/saritaradia/Desktop/Projects/recipes_directory/lib/04_reciperepository.rb'

RSpec.describe RecipeDirectoryRepository do
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipe_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_recipes_table
  end

  # (your tests will go here).
  it "Gets a single recipe" do
    repo = RecipeDirectoryRepository.new
    recipe = repo.all
    expect(recipe.length).to eq(3)
    expect(recipe[0].id).to eq('1')
    expect(recipe[0].name).to eq('Sandwich')
    expect(recipe[0].cooking_time).to eq('3')
    expect(recipe[0].rating).to eq('4')
  end
  # #2 Test real data - skip for now
  # it "Get all recipes where there are no recipes in the database" do
  #   repo = RecipeDirectoryRepository.new
  #   recipe = repo.all
  #   expect(recipe).to eq []
  # end

  it "Finds a single album ('Sandwich')" do
    repo = RecipeDirectoryRepository.new
    recipe = repo.find(1)
    expect(recipe.name).to eq('Sandwich')
    expect(recipe.cooking_time).to eq('3')
    expect(recipe.rating).to eq('4')
  end
end