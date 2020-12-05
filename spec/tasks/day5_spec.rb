# frozen_string_literal: true

describe Tasks::Day5::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(838) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(714) }
  end
end
