require './lib/models/user_repository'
require './lib/github_data_fetcher/print_helper'

module GithubDataFetcher
  class UsersController
    include PrintHelper

    def show_public_repos(user_name)
      @user_repos = UserRepository.get_public_repos(user_name)

      unless @user_repos.empty?
        print_repo_details(user_name, @user_repos)
      else
        print_line('Not able to find public repositories for this user')
      end
    end
  end
end