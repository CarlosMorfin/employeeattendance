namespace :db do

  desc 'Load demo enviroment'
  task :demo => [
    'db:drop',
    'db:create',
    'db:schema:load',
    'db:seed',
    'db:examples',
  ]

  desc 'Load examples'
  task :examples => [:environment, :load_config] do
    puts "-- Loading examples"

    load ActiveRecord::Tasks::DatabaseTasks.db_dir + '/examples.rb'
  end

end
