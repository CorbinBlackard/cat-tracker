require "application_system_test_case"

class CatsTest < ApplicationSystemTestCase
  setup do
    @cat = cats(:one)
  end

  test "visiting the index" do
    visit cats_url
    assert_selector "h1", text: "Cats"
  end

  test "should create cat" do
    visit cats_url
    click_on "New cat"

    fill_in "Color", with: @cat.color
    fill_in "Last seen", with: @cat.last_seen
    fill_in "Location", with: @cat.location
    fill_in "Name", with: @cat.name
    fill_in "Notes", with: @cat.notes
    fill_in "Pattern", with: @cat.pattern
    fill_in "Temperament", with: @cat.temperament
    click_on "Create Cat"

    assert_text "Cat was successfully created"
    click_on "Back"
  end

  test "should update Cat" do
    visit cat_url(@cat)
    click_on "Edit this cat", match: :first

    fill_in "Color", with: @cat.color
    fill_in "Last seen", with: @cat.last_seen.to_s
    fill_in "Location", with: @cat.location
    fill_in "Name", with: @cat.name
    fill_in "Notes", with: @cat.notes
    fill_in "Pattern", with: @cat.pattern
    fill_in "Temperament", with: @cat.temperament
    click_on "Update Cat"

    assert_text "Cat was successfully updated"
    click_on "Back"
  end

  test "should destroy Cat" do
    visit cat_url(@cat)
    click_on "Destroy this cat", match: :first

    assert_text "Cat was successfully destroyed"
  end
end
