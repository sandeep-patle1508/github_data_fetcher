#!/usr/bin/env ruby
begin  
  require './lib/github_data_fetcher'
 rescue LoadError => e
   abort "Could not load 'github_data_fetcher'"
 end

GithubDataFetcher::App.new.run(ARGV)
