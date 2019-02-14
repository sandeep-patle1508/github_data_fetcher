module GithubDataFetcher
  class App
    def run(argv)
      if argv.size == 1 && !argv.first.empty?
        GithubDataFetcher::UsersController.new.show_public_repos(argv.first)
      else
        abort "please enter user name"
      end
    end
  end
end