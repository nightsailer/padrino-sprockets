# Padrino::Sprockets: Integrate Sprockets with Padrino

# Installation #

Install from RubyGems:

    $ gem install padrino-sprockets

Or include it in your project's `Gemfile` with Bundler:

    gem 'padrino-sprockets', :require => "padrino/sprockets"

# Usage #

Place your assets under these paths:

    app/assets/javascripts
    app/assets/images
    app/assets/stylesheets

Register sprockets in your application:

    class Redstore < Padrino::Application
      register Padrino::Sprockets
      sprockets  # :url => 'assets', :root => app.root
    end

Now you can access the assets as follows:

    #  visit /assets/application.js
    will find assets under these paths:
     => app/assets/javascripts/application.js
      => app/assets/javascripts/application.js.coffee
       => app/assets/javascripts/application.js.erb

To minify javascripts in production do the following:

In your Gemfile:

    gem 'jsmin'
    # or
    gem 'YUI'

In your app:

    class Redstore < Padrino::Application
      register Padrino::Sprockets
      sprockets :minify => (Padrino.env == :production)
    end

For more documentation about sprockets, please check [Sprockets](https://github.com/sstephenson/sprockets/)

# Helpers Usage #

## sprockets
     :root =>  'asset root' # default is app.root
     :url => 'assets'  # default map url, location, default is 'assets'

# Contributors

* @matthias-guenther
* @swistak
* @dommmel
* @charlesvallieres
* @jfcixmedia
* @stefl
* @mikesten


