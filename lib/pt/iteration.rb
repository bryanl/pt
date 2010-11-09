module Pt
  class Iteration
    def initialize(iteration)
      @iteration = iteration
    end

    def features
      cards.find_all{|s| s.story_type == "feature"}
    end

    def cards
      @cards ||= @iteration["stories"].map{|card_options| Card.new(card_options)}
    end
  end
end
