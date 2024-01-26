# frozen_string_literal: true

require_relative '../lib/iamworkingperson/national_holiday'

RSpec.describe NationalHoliday do
  describe '#fetch' do
    let(:date) { Date.new(2023, 1, 1) }

    before do
      allow_any_instance_of(NationalHoliday).to receive(:holidays).and_return(
        %w[2023-01-01 2023-01-02]
      )
    end

    it 'returns the days of national holidays in the specified month' do
      expect(NationalHoliday.new(date:).fetch).to contain_exactly(1, 2)
    end

    context 'when actually in January' do
      let(:date) { nil }

      it 'returns the days of national holidays in the specified month' do
        allow(Date).to receive(:today).and_return(Date.new(2023, 1, 8))

        expect(NationalHoliday.new(date:).fetch).to contain_exactly(1, 2)

        allow(Date).to receive(:today).and_call_original # Reset stub
      end
    end
  end
end
