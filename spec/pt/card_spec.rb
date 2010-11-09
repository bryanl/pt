require 'spec_helper'

describe Pt::Card do

  specify "knows its state" do
    card = Pt::Card.new 'current_state' => "started"
    card.state.should == "started"
  end

  context "with an accepted state" do
    let(:card) { Pt::Card.new 'current_state' => 'accepted' }

    specify "should be accepted" do
      card.should be_accepted
    end
  end


  context "with a value" do
    specify "deciphers a value of [$25K]" do
      card = Pt::Card.new 'name' => "New feature [$25K]"
      card.value.should == 25_000
    end

    specify "deciphers a value of [$25k]" do
      card = Pt::Card.new 'name' => "New feature [$25k]"
      card.value.should == 25_000
    end

    specify "deciphers a value of [$150]" do
      card = Pt::Card.new 'name' => "New feature [$150]"
      card.value.should == 150
    end

    specify "knows it has value" do
      card = Pt::Card.new 'name' => "New feature [$25k]"
      card.should be_valued
    end
  end

  context "without a value" do
    let(:card) { card = Pt::Card.new 'name' => "Some feature" }

    specify "has a value of 0" do
      card.value.should == 0
    end

    specify "has no value" do
      card.should_not be_valued
    end
  end

end
