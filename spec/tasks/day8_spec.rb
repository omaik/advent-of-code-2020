# frozen_string_literal: true

describe Tasks::Day8::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(1753) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(733) }
  end
end
