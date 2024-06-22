# frozen_string_literal: true

require 'rspec'
require_relative '../soccer_data'

describe SoccerData do
  let(:file_path) { File.expand_path('../../fixtures/soccer.dat', __FILE__) }

  subject { SoccerData.new(file_path) }

  describe '#calculate_team_with_minimun_spread' do
    it 'returns the name of the team with the least amount of spread' do
      expect(subject.calculate_team_with_minimun_spread).to eq('8. Aston_Villa')
    end
  end
end