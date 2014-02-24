# Padrino::Sprockets

Sprockets, also known as "the asset pipeline", is a system for pre-processing, compressing and serving up of javascript, css and image assets. `Padrino::Sprockets` provides integration with the Padrino web framework.

## Installation

Install from RubyGems:

```sh
$ gem install padrino-sprockets
```

Or include it in your project's `Gemfile` with Bundler:

```ruby
gem 'padrino-sprockets', :require => "padrino/sprockets"
```

## Usage

Place your assets under these paths:

```
app/assets/javascripts
app/assets/images
app/assets/stylesheets
```

Register sprockets in your application:

```ruby
class Redstore < Padrino::Application
  register Padrino::Sprockets
  sprockets  # :url => 'assets', :root => app.root, :js_compressor=>:uglify, :css_compressor=>:closure
end
```

Now when requesting a path like `/assets/application.js` it will look for a source file in one of these locations :

* `app/assets/javascripts/application.js`
* `app/assets/javascripts/application.js.coffee`
* `app/assets/javascripts/application.js.erb`

#### To minify javascripts in production do the following:

In your Gemfile:

```ruby
# enable js minification
gem 'uglifier'
#gem 'closure'
# enable css compression
gem 'yui-compressor'
```

In your app:

```ruby
class Redstore < Padrino::Application
  register Padrino::Sprockets
  sprockets :minify => (Padrino.env == :production), :js_compressor => :yui # can be any of the shorthand 
end
```

For more documentation about sprockets nd its builtin shorthands for compressors, 
have a look at the [Sprockets](https://github.com/sstephenson/sprockets/) gem.

To use a custom javascript compressor, you can pass the classname instead of a shorthand.
The class must have the same methods as one of the *Compressor classes in Sprockets, like
ClosurCompressor and should be required in your App class. See the [Sprockets source code](https://github.com/sstephenson/sprockets/)
for more on this.

```ruby
class Redstore < Padrino::Application
  register Padrino::Sprockets
  sprockets :minify => (Padrino.env == :production), :js_compressor => MyCustomCompressor 
end
```
You can use a custom CSS compressor by specifying the :css_compressor for sprockets. You can
use Sprockets's shorthand, or pass a custom compressor class instance.

```ruby
class Redstore < Padrino::Application
  register Padrino::Sprockets
  sprockets :minify => (Padrino.env == :production), :css_compressor => MyCustomCssCompressor.new
end
```

## Helpers Usage

### sprockets

```ruby
:root =>  'asset root' # default is app.root
:url => 'assets'  # default map url, location, default is 'assets'
```

## Contributors

* [@matthias-guenther](https://github.com/matthias-guenther)
* [@swistak](https://github.com/swistak)
* [@dommmel](https://github.com/dommmel)
* [@charlesvallieres](https://github.com/charlesvallieres)
* [@jfcixmedia](https://github.com/jfcixmedia)
* [@stefl](https://github.com/stefl)
* [@mikesten](https://github.com/mikesten)
