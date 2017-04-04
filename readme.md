# Travis CI API Client

Ruby client for the [Travis CI API, version 3](https://developer.travis-ci.com/).

## Installation

You can install it as a RubyGem via:

``` console
$ gem install travis-client
```

Note that it does conflict with [travis.rb](https://github.com/travis-ci/travis.rb) at the moment, as both of them add a `travis/client` file. It is highly recommended to use [Bundler](http://bundler.io/) to avoid accidentally loading the wrong gem in your scripts.

## Getting Started

This library has two general ways to use it. An interface based on globals, that should feel quite natural to Ruby developers:

``` ruby
require 'travis/client'
Travis.connect # call before interacting with anything else
repository = Travis::Repository.find(slug: 'travis-ci/travis-web')
```

Or an approach based on sessions, which helps avoiding global state, and easily allows multiple connections in parallel with different credentials or even different Travis CI installations:

``` ruby
require 'travis/client'
connection = Travis.new
session    = connection.create_session
repository = session.find_repository(slug: 'travis-ci/travis-web')
```

Objects returned by `Repository.find` and `find_repository` are identical. You can access the underlying session object used by `Travis::Repository.find` via `Travis.session`.

Each session will have its own cache, and HTTP connections. Recreating connection objects (by either calling `Travis.connect` or `Travis.new`) frequently should be avoided, as it will rebuild internal factories based on the API auto-discovery.

Both `Travis.new` and `Travis.connect` accept the following options:

* **endpoint:** URI for the entry point to the Travis CI API, defaults to `https://api.travis-ci.org`. Set this to `https://api.travis-ci.com` for the Pro version of Travis CI, `https://travis.your-domain.com/api`  for Travis CI Enterprise (assuming your Enterprise web UI is reachable under `https://travis.your-domain.com`).
* **request_headers:** Allows defining additional headers to be sent to Travis CI with every HTTP request. Can also be used to override headers, like `User-Agent`.
* **access_token:** API access token to use for authentication.

## Advanced Features

### Authentication

You'll need an API token to authenticate. The library currently does not offer a way to obtain such a token, the easiest way to obtain such a token is to visit the developer pages and hover over the token in a code example and copy the value. Please note that there are separate tokens for [travis-ci.org](https://developer.travis-ci.org/explore/user) and [travis-ci.com](https://developer.travis-ci.com/explore/user), and you will have to use the appropriate token depending on which API you interact with.

Alternatively, you can use the [`token` command](https://github.com/travis-ci/travis.rb#token) from the CLI.

``` ruby
# connecting to travis-ci.org with a token stored in TRAVIS_TOKEN env var
Travis.connect(access_token: ENV['TRAVIS_TOKEN'])

# connecting to travis-ci.com with a token stored in TRAVIS_PRO_TOKEN env var
Travis.connect(api_endpoint: 'https://api.travis-ci.com' access_token: ENV['TRAVIS_PRO_TOKEN'])
```

When using multiple sessions, the token may either be passed to the connection (in which case it will be used fo all sessions) or each session individually:

``` ruby
connection = Travis.new(access_token: ENV['TRAVIS_TOKEN'])
puts connection.create_session.current_user.login


# for a list of tokens, output which user is associated with it
access_tokens = [ ... list of tokens ... ]
connection    = Travis.new(api_endpoint: 'https://api.travis-ci.com')
access_tokens.each do |token|
  session     = connection.create_session(access_token: token)
  puts session.current_user.login
end
```

### Caching and Session Renewal

Each session will have it's own cache. If you have long running processes and concerns about cache size or stale caches, then the easiest and cleanest way to deal with this is to discard session objects after a while and not hold on to any entities associated with it.

In a web application (like Rails or Sinatra), it is recommended to use a new session per request, or per background job. This will also greatly decrease threading issues (see below).

``` ruby
require 'sinatra'
require 'travis/client'

# create connection once, but create one session per request
connection = Travis.new(access_token: ENV['TRAVIS_TOKEN'])
before { @travis = connection.create_session }

get '/' do
  "Hello, #{@travis.current_user.name}!"
end
```

If you do have to clear a session's cache, you can do so via `session.response_cache.clear` or `Travis.clear_cache`. However, this is not recommended and any response objects that might still be referenced somewhere will probably end up with a mix of outdated and recent data.

### Thread Safety

Neither `Travis.connect` nor loading resources is currently thread-safe, with the notable exception of `Connection#create_session`. You still can (and should) use it in a threaded environment.

To use with a threaded environment:

* Initialize a new connection once, via `Travis.new`.
* From this connection, create one session per thread via `#create_session`.

Example that fetches repositories in parallel:

``` ruby
require 'travis/client'

repositories = ['travis-ci/travis-web', 'travis-ci/travis-api', 'sinatra/sinatra']
connection   = Travis.new
threads      = repositories.map do |slug|
  Thread.new { connection.create_session.find_repository(slug: slug) }
end

threads.each do |thread|
  puts thread.value.name
end
```

### Permission Checks

You can check permissions on any entity object via the `permission?` method:

``` ruby
Travis::User.current.permission? :sync                    # => true
Travis::Owner.find(login: 'svenfuchs').permission? :sync  # => false

user = Travis::User.current
user.sync if user.permission? :sync
```

You can find a full list of permission in the [developer documentation](https://developer.travis-ci.org/).

### Eager Loading

The following code will trigger two HTTP requests, one to fetch the repository, and one to fetch the last build on the default branch:

``` ruby
repository = Travis::Repository.find(slug: 'travis-ci/travis-api')
puts repository.default_branch.last_build.state
```

You can reduce this to a single HTTP request by eager loading `branch.last_build`:

``` ruby
repository = Travis::Repository.find(slug: 'travis-ci/travis-api', include: 'branch.last_build')
puts repository.default_branch.last_build.state
```

### Pagination

Each object representing a collection is an Enumerable and will handle pagination in a transparent way:

``` ruby
# will automatically paginate if necessary
repository.branches.map { |branch| branch.name }
```

Just like with missing attributes, the code will trigger any additional HTTP requests lazily, but only once, so exiting a loop over a collection prematurely (for instance, by using `break` or `return`) might reduce the number of HTTP requests.

You can also use the `limit`, `offset` and `sort` parameters to fine-tune requests.

### Request Hooks and Instrumentation

You can add hooks that will trigger before or after any HTTP request:

``` ruby
Travis.before_request { |r| puts "** #{r.request_method} #{r.uri}"}
Travis::Repository.find(slug: 'rails/rails')
```

You can use the `meta_data` hash to share data between hooks:

``` ruby
Travis.before_request do |request|
  request.meta_data[:start] = Time.now
end

Travis.after_request do |request|
  duration = Time.now - request.meta_data[:start]
  puts "** #{request.request_method} #{request.uri} - #{request.response.status} - #{duration}s"
end

Travis::Repository.find(slug: 'rails/rails')
```
