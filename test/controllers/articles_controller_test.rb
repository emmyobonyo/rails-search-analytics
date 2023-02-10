class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @article = Article.create(title: 'Rails', body: 'Getting started with Rails', user_id: 1)
    @user = User.create(username: 'obonyo', email: 'obonyo@gmail.com', password: 'password', most_searched_themes: ['Rails'])
  end

  test "should get new" do 
    get new_article_url
    assert_response :success
  end
end