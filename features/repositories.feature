Feature: Repositories
  In order to get informatio about the Travis CI repoisitories
  As ruby application
  I want to get the the repositories information through the API wrapper

  Scenario Outline: Get all repositories
    Given I am using the Travis::API::Client::Repositories client
    When I request <method>
    Then I should get a collection of Travis::API::Entity::Repository instances
  
  Examples:
    |method |
    |all    |
    |all!   |

  Scenario Outline: Get a repository by name and owner
    Given I am using the Travis::API::Client::Repositories client
    When I set the name to "travis-ci"
    And I set the owner to "travis-ci"
    And I request <method>
    Then I should get a Travis::API::Entity::Repository
    And the result should have the following values:
      | name  | travis-ci           |
      | owner | travis-ci           |
      | slug  | travis-ci/travis-ci |
    And the result should have the following numeric values:
      | id    | 59                  |

  Examples:
    |method |
    |fetch  |
    |fetch! |

# Right now there's no way to get a repository directly by id.
#
# We are iterating over the recent repositories trying to find the target repo by id.
#
# It will fail most of the times since the recent repositories is a really small list.
#
# Looking forward for an API call to get repos by id or at list one to get all the repos and 
# not just the recent ones.
#
#  Scenario Outline: Get a repository by name and owner
#    Given I am using the Travis::API::Client::Repositories client
#    When I set the id to "59"
#    And I request <method>
#    Then I should get a Travis::API::Entity::Repository
#    And the result should have the following values:
#      | name  | travis-ci           |
#      | owner | travis-ci           |
#      | slug  | travis-ci/travis-ci |
#    And the result should have the following numeric values:
#      | id    | 59                  |
#
#  Examples:
#    |method |
#    |fetch  |
#    |fetch! |
#

  Scenario Outline: Get a repository by name and owner
    Given I am using the Travis::API::Client::Repositories client
    When I set the slug to "travis-ci/travis-ci"
    And I request <method>
    Then I should get a Travis::API::Entity::Repository
    And the result should have the following values:
      | name  | travis-ci           |
      | owner | travis-ci           |
      | slug  | travis-ci/travis-ci |
    And the result should have the following numeric values:
      | id    | 59                  | 

  Examples:
    |method |
    |fetch  |
    |fetch! |

  Scenario Outline: Get the builds from a repository
    Given I am using the Travis::API::Client::Repositories client
    When I set the owner to "travis-ci"
    And I set the name to "travis-ci"
    And I request <method>
    Then I should get a collection of Travis::API::Entity::Build instances

  Examples:
    |method  |
    |builds  |
    |builds! |

  Scenario Outline: Get a build from a repository by id
    Given I am using the Travis::API::Client::Repositories client
    When I set the owner to "travis-ci"
    And I set the name to "travis-ci"
    And I request <method> with the following params:
      |69619 |
    Then I should get a Travis::API::Entity::Build
    And the result should have the following values:
      | author_email  | svenfuchs@artweb-design.de                                                      |
      | author_name   | Sven Fuchs                                                                      |
      | branch        | statemachine                                                                    |
      | commit        | 04beda102abcb37b353e406663535d2bc2c4da5c                                        |
      | committed_at  | 2011-08-07T00:03:40Z                                                            |
      | compare_url   | https://github.com/travis-ci/travis-ci/compare/5878605...04beda1                |
      | finished_at   | 2011-08-07T00:18:36Z                                                            | 
      | message       | Merge branch 'statemachine' of github.com:travis-ci/travis-ci into statemachine |
      | number        | 772                                                                             |
      | started_at    | 2011-08-07T00:14:41Z                                                            |
    And the result should have the following numeric values:
      | id            | 69619                                                                           |
      | repository_id | 59                                                                              |
      | status        | 1                                                                               |
    And the result should respond to "matrix" with a collection of Travis::API::Entity::Build instances
    And the result should respond to "repository" with a Travis::API::Entity::Repository instances
  Examples:
    |method |
    |build  |
    |build! |
