# frozen_string_literal: true

describe Entities::SeatMap do
  let(:map) do
    <<~EOF
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    EOF
  end

  it { expect(described_class.new(map).stabilize).to eq(37) }
  it { expect(described_class.new(map).stabilize(:next_by_visible)).to eq(26) }
end
