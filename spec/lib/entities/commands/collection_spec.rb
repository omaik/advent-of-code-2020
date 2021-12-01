# frozen_string_literal: true

describe Entities::Commands::Collection do
  describe '#call' do
    let(:text) do
      <<~QUE
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
      QUE
    end

    it { expect(described_class.new(text).call).to eq(5) }
  end

  describe '#call_with_correction' do
    let(:text) do
      <<~QUE
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
      QUE
    end

    it { expect(described_class.new(text).call_with_correction).to eq(8) }
  end
end
