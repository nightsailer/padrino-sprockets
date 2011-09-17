= Padrino::Sprockets: Play padrion with Sprockets

# Installation #

Install from RubyGems:

    $ gem install padrino-sprockets

Or include it in your project's `Gemfile` with Bundler:

    gem 'padrino-sprockets'

# Usage #

Your assets place under these path:
    
    app/assets/javascripts
    app/assets/images
    app/assets/stylesheets
    
regsiter sprockets in your application:

    class Redstore < Padrino::Application
      register Padrino::Sprockets
      sprockets  # :url => 'assets', :root => app.root
    end

Now, you can access the asset follow:

    #  visit /assets/application.js
    will find assets under these paths:
     => app/assets/javascripts/application.js
      => app/assets/javascripts/application.js.coffee
       => app/assets/javascripts/application.js.erb
    
More document about sprockets, please check [Sprockets](https://github.com/sstephenson/sprockets/)

# Helpers #
 
 sprockets
     :root =>  'asset root' # default is app.root
     :url => 'assets'  # default map url,location, default is 'assets'

     
