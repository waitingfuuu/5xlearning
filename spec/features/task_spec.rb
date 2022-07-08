require 'rails_helper'

feature "tasks", :type => :feature do

  before(:each) do
    @task = Task.new
    @task.title = "oldtitle"
    @task.save
  end

  scenario "when create task" do

    visit new_task_path

    expect(page).to have_content("新增任務")

    within("#task_form") do
      fill_in "task[title]", with: "newtask"
      fill_in "task[content]", with: "iamanewtask"
      fill_in "task[tag]", with: "test"
    end

    click_button "新增"
    
    expect(page).to have_content("newtask")

    task = Task.last
    expect(task.title).to eq("newtask")
  end
  
  scenario "when edit task" do

    visit root_path

    expect(page).to have_content("Task")

    click_link "編輯"

    expect(page).to have_content("編輯任務")

    within("#task_form") do
      fill_in "task[title]", with: "changetitle"
      fill_in "task[content]", with: "iamdifferent"
    end

    click_button "修改"
    
    expect(page).to have_content("changetitle")

    task = Task.last
    expect(task.title).to eq("changetitle")
  end
  
  scenario "when delete task" do

    visit root_path

    expect(page).to have_content("Task")

    click_link "刪除"
    
    expect(page).to have_no_content("oldtitle")

    task = Task.find_by title: "oldtitle"
    expect(task).to be_nil
  end

end