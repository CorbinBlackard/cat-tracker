require "test_helper"

class CatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cat = cats(:one)
  end

  test "should get index" do
    get cats_url
    assert_response :success
  end

  test "should get new" do
    get new_cat_url
    assert_response :success
  end

  test "should create cat" do
    assert_difference("Cat.count") do
      post cats_url, params: { cat: { color: @cat.color, last_seen: @cat.last_seen, location: @cat.location, name: @cat.name, notes: @cat.notes, pattern: @cat.pattern, temperament: @cat.temperament } }
    end

    assert_redirected_to cat_url(Cat.last)
  end

  test "should show cat" do
    get cat_url(@cat)
    assert_response :success
  end

  test "should get edit" do
    get edit_cat_url(@cat)
    assert_response :success
  end

  test "should update cat" do
    patch cat_url(@cat), params: { cat: { color: @cat.color, last_seen: @cat.last_seen, location: @cat.location, name: @cat.name, notes: @cat.notes, pattern: @cat.pattern, temperament: @cat.temperament } }
    assert_redirected_to cat_url(@cat)
  end

  test "should destroy cat" do
    assert_difference("Cat.count", -1) do
      delete cat_url(@cat)
    end

    assert_redirected_to cats_url
  end
end
