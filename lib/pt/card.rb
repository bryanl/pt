module Pt
  class Card
    def initialize(card)
      @card = card
    end

    %w[story_type name].each do |field|
      define_method field.to_sym do
        @card[field]
      end
    end

    def value
      @value ||= case name
      when %r{\[\$(\d+)[Kk]\]}
        $1.to_i * 1_000
      when %r{\[\$(\d+)\]}
        $1.to_i
      else
        0
      end
    end

    def valued?
      value > 0
    end

    def accepted?
      state == 'accepted'
    end

    def state
      @card["current_state"]
    end
  end
end
