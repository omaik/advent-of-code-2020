# frozen_string_literal: true

describe Entities::Ship do
  let(:instructions) do
    <<~EOF
      F10
      N3
      F7
      R90
      F11
    EOF
  end

  it { expect(described_class.move_by_instructions(instructions.split("\n"))).to eq(25) }
  it { expect(described_class.move_by_waipoint(instructions.split("\n"))).to eq(286) }
end
