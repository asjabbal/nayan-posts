# How to run the project
1. Clone git repository
	- `$ git clone https://github.com/asjabbal/nayan-posts.git`
2. Go to cloned repo
	- `$ cd nayan-posts`
3. Install gems
	- `$ bundle install`
4. Create db and run migrations
	- `$ DB_HOST=<db_host> DB_USERNAME=<db_un> DB_PASSWORD=<db_pass> DB_NAME=<db_name> rake db:drop db:create db:migrate --trace`
5. Run cron job to fetch data from Contentful API and save to db
	- `$ DB_HOST=<db_host> DB_USERNAME=<db_un> DB_PASSWORD=<db_pass> DB_NAME=<db_name> clockwork clock.rb`
	- Stop above cmd once you see `--- DONE ---` using `ctcl+c` otherwise it will keep on fetching the data
6. Run app server
	- `$ DB_HOST=<db_host> DB_USERNAME=<db_un> DB_PASSWORD=<db_pass> DB_NAME=<db_name> rails s`