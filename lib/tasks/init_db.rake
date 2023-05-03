namespace :init_db do
  desc "Initialize databases if databases aren't exist"
  task setup: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    initialise_db unless databases_exists?
  end

  desc 'Reset databases'
  task reset: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    Rake::Task['db:drop'].execute if databases_exists?
    initialise_db
  end

  def initialise_db
    system 'bundle exec rails db:create'
    system 'bundle exec rails db:migrate'
    system 'bundle exec rails db:seed'
  end

  def databases_exists?
    ActiveRecord::Base.connection
    true
  rescue ActiveRecord::NoDatabaseError
    false
  end
end
