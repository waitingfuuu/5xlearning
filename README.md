# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

table schema
model: user
id int
name string
pw string
admin bool

model: task
task_id int
task_user string
task_title string
task_content string
task_tag string
task_build_time int
task_start_time int
task_end_time int
task_priority int
task_state int