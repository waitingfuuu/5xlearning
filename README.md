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

## Database Models

* Model: Task

	- `user_id` integer
	- `title` string
	- `content` string
	- `tag` string
	- `start_time` datetime
	- `end_time` datetime
	- `priority` string
	- `state` string

## Heroku

https://training5x-wt.herokuapp.com/

* App Information

	- App Name: training5x-wt
	- Region: United States
	- Stack: heroku-20
	- Framework: Ruby

* 佈署方法

	1. 註冊 / 登入 Heroku 帳號
	2. 新增一個 App ( New -> Create new app )
	3. 安裝 Heroku CLI ( `brew tap heroku/brew && brew install heroku` )
	4. 新增一個 pipeline 並將此專案加入 ( Deploy -> Create a pipeline -> Add this app to the pipeline )
	5. 使用終端機登入 Heroku ( `heroku login` )
	6. 設定 Heroku 遠端連接 ( `heroku git:remote -a training5x-wt` )
	7. 將專案上傳到 Heroku ( `git push heroku main` )
	8. 在 Heroku 執行 Migration ( `heroku run rake db:migrate` )
	9. 設定初始環境 ( `heroku ps:scale web=1` )
	10. 打開專案 ( `heroku open` )