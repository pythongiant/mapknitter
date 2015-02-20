require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  # called before every single test
  def setup
    @map = maps(:saugus)
  end 

  # called after every single test
  def teardown
  end

  test "should not create comment if not logged in" do
    post(:create, 
      map_id: @map.slug,
      comment: {
        user_id: 1
    })
    assert_redirected_to "/login?back_to=/maps/#{@map.slug}"
    assert_empty @map.comments
  end

  test "should create comment" do
    session[:user_id] = 1

    post(:create, 
      map_id: @map.slug,
      comment: {
        body: "I'm gonna troll you!", 
        user_id: 1
    })
    assert_redirected_to '/maps/'+@map.slug
    assert_not_empty @map.comments
  end

end
