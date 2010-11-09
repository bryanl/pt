require 'thor'
require 'thor/actions'
require 'pt/summary'

require 'pt/iteration'
require 'pt/card'

module Pt
  class CLI < Thor
    include Thor::Actions

    default_task :summary

    desc "summary", "Get a summary of an iteration's value"
    def summary
      options = YAML.load_file(File.join(ENV["HOME"], ".ptrc"))

      pt_summary = Summary.new(options)
      total = 0
      sorted_features = pt_summary.current.features_with_value.sort do |a,b|
        a.value <=> b.value
      end
      sorted_features.each do |card|
        puts "%10d: %s" % [card.value, card.name]
        total += card.value
      end

      puts "\nThe value of current work $#{total}"


      bug_total = 0
      sorted_bugs = pt_summary.bug_value.sort do |a,b|
        a.value <=> b.value
      end
      sorted_bugs.each do |card|
        puts "%10d: %s" % [card.value, card.name]
        bug_total += card.value
      end

      puts "\nThe value of outstanding bugs $#{bug_total}"
      puts "\nThe value of the current iteration = $#{total - bug_total}"
    end


  end
end

