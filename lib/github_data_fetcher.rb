# load all the files inside github_data_fetcher folder
Dir.glob('./lib/github_data_fetcher/**/*.rb').each do |file|
  require file
end
