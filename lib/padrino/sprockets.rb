# encoding: utf-8
require "sprockets/environment"
module Padrino
  module Sprockets
    class << self
      def registered(app)
        app.helpers Helpers
      end
    end
    module Helpers
      module ClassMethods
        def sprockets(options={})
          url   = options[:url] || 'assets'
          _root = options[:root] || root
          set :sprockets_url, url
          use Padrino::Sprockets::App,:root => _root,:url => url
        end
      end
      def self.included(base)
        base.extend         ClassMethods
      end
    end #Helpers
    class App
      def initialize(app, options={})
        @app = app
        @root = options[:root]
        url   =  options[:url] || 'assets'
        @matcher = /^\/#{url}\/*/
        @environment = ::Sprockets::Environment.new(@root) do |env|
        end
        @environment.append_path 'assets/javascripts'
        @environment.append_path 'assets/stylesheets'
        @environment.append_path 'assets/images'
      end
      def call(env)
        path = env["PATH_INFO"]
        logger.debug { "path:#{path} url:#{@url}" }
        return @app.call(env) unless @matcher =~ path
        env['PATH_INFO'].sub!(@matcher,'')
        @environment.call(env)
      end
    end
  end #Sprockets
end #Padrino