require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

desc "initialize missing uuids on persisted screencast data"
task "initialize_missing_uuids" do
  require 'das_catalog'

  DasCatalog::Store.all.each do |screencast_data|
    screencast_data.initialize_uuid
    screencast_data.save
  end
end
