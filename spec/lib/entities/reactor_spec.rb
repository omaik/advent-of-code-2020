describe Entities::Reactor do
  let(:input) do
    <<~EOF
.##..#.#
##.#...#
##.#.##.
..#..###
####.#..
...##..#
#.#####.
#.#.##.#
    EOF
  end

  it { expect(described_class.new(input).call).to eq(1) }
end
