require 'httparty'
require 'pt/iteration'
require 'pt/card'

module Pt
  class Summary
    include HTTParty

    base_uri 'www.pivotaltracker.com'
    format :xml

    def initialize(options)
      @options = options
      self.class.headers("X-TrackerToken" => options[:token])
    end

    def current
      self
    end

    def features_with_value
      parsed_response = get("#{project}/iterations/current").parsed_response
      iteration = Iteration.new(parsed_response["iterations"].first)
      iteration.features.find_all(&:accepted?)
    end

    def bug_value
      [].tap do |stories|
        raw_stories = get("#{project}/stories", :query => "filter=type:Bug").parsed_response
        raw_stories["stories"].each do |story_options|
          stories << Card.new(story_options)
        end
      end
    end

    private

    def project
      %Q{/services/v3/projects/#{@options[:project]}}
    end

    def get(*args)
      self.class.get(*args)
    end
  end

end
