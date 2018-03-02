require 'yaml'
require 'digest/sha2'

require 'workshopper/content'
require 'workshopper/loader'

module Workshopper

  class Workshop

    def initialize(url)
      @url = url
      @data = Workshopper::Loader.get(@url)
      @data = YAML.load(@data)

      @id = @data['id']

      @content = Content.new(prefix)
    end

    def prefix
      @data['content']['url']
    end

    def id
      @id ||= Digest::SHA256.hexdigest(@url)
    end

    def name
      @data['name']
    end

    def active_labs
      @data['modules']['activate']
    end

    def lab(name)
      @content.lab(name)
    end

    def issues
      @content.issues
    end

  end

end