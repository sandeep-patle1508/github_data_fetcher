# Github Data Fetcher

A command line application which access Github API and pull out public repositories of an user and then display on screen.

You can fine Github API document here - https://developer.github.com/v3/repos/

## Setup
* clone the repository `git clone git@github.com:sandeep-patle1508/github_data_fetcher.git`
* `cd github_data_fetcher`
* `bin/setup`

## Usage
Pass the github user_name with following command from root folder -
`./fetch_public_repos.rb <user_name>`

For example
`./fetch_public_repos.rb sandeep-patle1508`

It will display result in below foramt -
```
List of public repositories of sandeep-patle1508
angular-bootstrap-lightbox - https://github.com/sandeep-patle1508/angular-bootstrap-lightbox
authority - https://github.com/sandeep-patle1508/authority
bitmap_editor - https://github.com/sandeep-patle1508/bitmap_editor
bootstrap - https://github.com/sandeep-patle1508/bootstrap
```

If user is not present then you will see error on the screen -
```
Not able to find public repositories for this user
```

## Test
After checking out the repo, run `bin/test` to run the tests. 

## Tools
* Ruby 2.5.1p57
* HTTParty Gem
* Rspec
* webmock