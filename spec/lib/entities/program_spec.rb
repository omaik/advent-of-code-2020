# frozen_string_literal: true

describe Entities::Program do
  let(:lines) do
    <<~EOF
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
    EOF
  end

  let(:lines2) do
    <<~EOF
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
    EOF
  end

  it { expect(described_class.new(lines.split("\n")).execute).to eq(165) }
  it { expect(described_class.new(lines2.split("\n")).execute2).to eq(208) }
end
