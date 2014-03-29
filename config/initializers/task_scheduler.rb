  require 'rubygems'
  require 'rufus/scheduler'

  scheduler = Rufus::Scheduler.new
  scheduler.every '1d' do
 	 system "rake sitemap:refresh"
  end
