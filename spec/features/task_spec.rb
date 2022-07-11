require 'rails_helper'

FactoryBot.define do
  factory :task do
    user_id { Faker::Number.decimal_part(digits: 2) }
    title { Faker::Job.title }
    content { Faker::String.random }
    tag { Faker::String.random(length: 4) }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    end_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 1, format: :default) }
    priority { "高" }
    state { "處理中" }
  end
end

feature "tasks", :type => :feature do

  before(:each) do
    FactoryBot.create(:task)
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
      fill_in "task[content]", with: "new content"
      fill_in "task[tag]", with: "newtag"
    end

    click_button "修改"
    
    expect(page).to have_content("changetitle")
    expect(page).to have_content("new content")
    expect(page).to have_content("newtag")

    task = Task.last
    expect(task.title).to eq("changetitle")
  end
  
  scenario "when delete task" do

    visit root_path

    expect(page).to have_content("Task")

    click_link "刪除"
    
    expect(page).to have_no_content("apple")

    task = Task.find_by title: "apple"
    expect(task).to be_nil
  end

end