# frozen_string_literal: true

describe Tasks::Day4::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(202) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(137) }
  end
end
