require 'spec_helper'

describe "Creating todo lists" do
  def create_to_do_list(options={})
  	options[:title] ||= "My todo list"
  	options[:description] ||= "This is my todo list."


  	visit "/todo_lists"
    click_link "New Todo list"
	expect(page).to have_content("New todo_list")

    fill_in "Title", with: options[:title]
	fill_in "Description", with: options[:description]
	click_button "Create Todo list"
  end

  it "redirects to the todo list index page on success" do
	  create_to_do_list
	  expect(page).to have_content("My todo list")
  end	  
  it "displays error when todo list has no title" do
     expect(TodoList.count).to eq(0)
      create_to_do_list title: ""

	  expect(page).to have_content("error")
	  expect(TodoList.count).to eq(0)

	  visit "/todo_lists"
	  expect(page).to_not have_content("This is what I'm doing today.")
  end

  it "displays error when title has less than 3 characters" do
     expect(TodoList.count).to eq(0)
      create_to_do_list title: "Hi"

	  expect(page).to have_content("error")
	  expect(TodoList.count).to eq(0)

	  visit "/todo_lists"
	  expect(page).to_not have_content("This is what I'm doing today.")
  end
    it "displays error when todo list has no description" do
     expect(TodoList.count).to eq(0)
     create_to_do_list title: "Grocery list", description: ""

	  expect(page).to have_content("error")
	  expect(TodoList.count).to eq(0)

	  visit "/todo_lists"
	  expect(page).to_not have_content("Grocery list")
  end

      it "displays error when todo list has less than 5 description characters" do
     expect(TodoList.count).to eq(0)
      create_to_do_list title: "Grocery list", description: "Food"

	  expect(page).to have_content("error")
	  expect(TodoList.count).to eq(0)

	  visit "/todo_lists"
	  expect(page).to_not have_content("Grocery list")
  end
end