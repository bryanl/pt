require 'spec_helper'

describe Pt::Summary do

  describe "features with value" do

    let(:response) { mock('response', :[] => []) }
    let(:card1) { stub(:name => "card1", :value => "123", :accepted? => false) }
    let(:card2) { stub(:name => "card1", :value => "123", :accepted? => false) }
    let(:card3) { stub(:name => "card1", :value => "123", :accepted? => true) }
    let(:iteration) { stub(:features => [card1, card2, card3]) }

    let(:summary_options) { {} }

    let(:all_expected_features) { [card1, card2, card3] }
    let(:filtered_expected_features) { [card3] }

    before do
      Pt::Iteration.stub(:new) { iteration }
      subject.stub(:raw_features_with_value) { stub(:parsed_response => response) }
    end

    subject { Pt::Summary.new(summary_options) }

    specify "returns all features" do
      subject.features_with_value.should == all_expected_features
    end

    specify "returns accepted features when specified" do
      subject.features_with_value(true).should == filtered_expected_features
    end
  end

end
