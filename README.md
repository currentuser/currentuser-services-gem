# currentuser-services

This is an experimental project. It should not be used for now.

## Configuration (In progress)

Create your application on ...

```ruby
# config/initializers/currentuser.rb
Currentuser::Services.configure do |config|
  config.application_id = 'your_app_id'
end
```

## Usage  (In progress)

* Use `:require_currentuser` as `before_action` to protect your restricted actions
** In these actions (and their views) you can use `currentuser_id` to retrieve the id of the connected user
* Use `sign_up_url` and `sign_in_url` in your navigation to allow visitor to sign up and sign in
* Build an action that calls `sign_out` to sign out connected user


### Example

#### Routes

```ruby
# config/routes.rb
MyApplication::Application.routes.draw do
  root 'main#index'
  resources :my_resources, only: [:index]
  resource :session, only: [:destroy]
end
```

#### Controllers
```ruby
class MainController < ApplicationController
end
```
```ruby
class MyResourcesController < ApplicationController
  before_action :require_currentuser

  def index
    render text: currentuser_id
  end
end
```
```ruby
class SessionsController < ApplicationController
  def destroy
    sign_out
    redirect_to :root
  end
end
```

#### Views

```haml
-# views/home/index.rb
= render 'shared/menu'

%h1 Welcome to this great application!

= link_to 'Sign Up', sign_up_url
```

```haml
-# views/shared/_menu.html.haml
%ul
  - if currentuser_id
    %li
      = link_to 'Home', :root
    %li
      = link_to 'My resources', :resources
    %li
      = link_to 'Sign out', :session, method: :delete
  - else
    %li
      = link_to 'Sign in', sign_in_url
```

## Contributing to currentuser-data (not recommended yet)

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
