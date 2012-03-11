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
        @environment = ::Sprockets::Environment.new(@root)
        @environment.append_path 'assets/javascripts'
        @environment.append_path 'assets/stylesheets'
        @environment.append_path 'assets/images'
        if @app.settings.sprockets_paths
          @app.settings.sprocket_paths.each do |sprocket_path|
            @environment.append_path sprocket_path
          end
        end
      end
      def call(env)
        return @app.call(env) unless @matcher =~ env["PATH_INFO"]
        env['PATH_INFO'].sub!(@matcher,'')
        @environment.call(env)
      end
    end
  end #Sprockets
end #Padrino