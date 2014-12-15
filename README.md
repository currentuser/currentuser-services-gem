# currentuser-services

Offsite sign up and sign in forms for [Currentuser.io](http://www.currentuser.io).

If you want to manage your own sign_up, sign_in and sign_out actions you should use the gem `currentuser-data` instead.

## Configuration

Create your project on [Currentuser.io](http://www.currentuser.io).

Add `currentuser-services` gem in your `Gemfile`:
```ruby
# Gemfile
gem 'currentuser-services'
```
Add an initializer file:
```ruby
# config/initializers/currentuser.rb (the exact name of the file has no impact)
Currentuser::Services.configure do |config|
  config.project_id = 'your_project_id'
end
```
Call `currentuser` in your routes definition:
```ruby
# config/routes.rb
MyApplication::Application.routes.draw do
  currentuser
end
```

## Usage

* Use `currentuser_sign_up_url`, `currentuser_sign_in_url` and `currentuser_sign_out_url`in your navigation to allow
 visitor to sign up, in and out
* Use `:require_currentuser` as `before_action` to protect your restricted actions
* In any action or view, you can use `currentuser_id` to retrieve the id of the connected user (if any)

That's all! Note that:

* you don't need to generate and run migrations. Currentuser does NOT rely on your database
* you don't need to generate, analyse and modify a complicated configuration file.

### Example

#### Routes

```ruby
# config/routes.rb
MyApplication::Application.routes.draw do
  root 'main#index'
  get :restricted, to: 'main#restricted'
  currentuser
end
```

#### Controller

```ruby
class MainController < ApplicationController
  before_action :require_currentuser, only: :restricted
end
```

#### Views

```haml
-# views/home/index.html.haml
= render 'shared/menu'

%h1
  Welcome!
```

```haml
-# views/home/restricted.html.haml
= render 'shared/menu'

%h1
  Welcome back to this restricted area, #{currentuser_id}
```

```haml
-# views/shared/_menu.html.haml
%ul
  - if currentuser_id
    %li
      = link_to 'Home', :root
    %li
      = link_to 'Restricted', :restricted
    %li
      = link_to 'Sign out', currentuser_sign_out_url
  - else
    %li
      = link_to 'Sign up', currentuser_sign_up_url
    %li
      = link_to 'Sign in', currentuser_sign_in_url
```

## Contributing to currentuser-services (not recommended yet)

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Tests

TBD

## Copyright

Copyright (c) 2014 eric-currentuser. See LICENSE.txt for further details.
