module GithubDataFetcher
  module PrintHelper

    # display result on screen
    def print_repo_details(user_name, user_repos)
      print_line("List of public repositories of #{user_name}")

      user_repos.each do |user_repo|
        print_line("#{user_repo.name} - #{user_repo.html_url}")
      end
    end

    def print_line(line)
      puts line
    end
  end
end