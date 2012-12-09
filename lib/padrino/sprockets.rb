# encoding: utf-8
require "sprockets"
require "tilt"

module Sprockets
  class JSMinifier < Tilt::Template
    def prepare
    end

    def evaluate(context, locals, &block)
      JSMin.minify(data)
    end
  end
end

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
          paths = options[:paths] || []
          set :sprockets_url, url
          options[:root] = _root
          options[:url] = url
          options[:paths] = paths
          use Padrino::Sprockets::App, options
        end
      end
      def self.included(base)
        base.extend         ClassMethods
      end
      module AssetTagHelpers
        # Change the folders to /assets/
        def asset_folder_name(kind)
          case kind
          when :css then 'assets'
          when :js  then 'assets'
          else kind.to_s
          end
        end
      end # AssetTagHelpers
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
        if options[:minify]
          if defined?(YUI)
            @environment.css_compressor = YUI::CssCompressor.new
          else
            puts "Add yui-compressor to your Gemfile to enable css compression"
          end
          if defined?(JSMin)
            @environment.register_postprocessor "application/javascript", ::Sprockets::JSMinifier
          else
            puts "Add jsmin to your Gemfile to enable minification"
          end
        end
        options[:paths].each do |sprocket_path|
          @environment.append_path sprocket_path
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