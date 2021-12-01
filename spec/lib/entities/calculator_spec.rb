describe Entities::Calculator do
  let(:input) { '2 + 2 * 2' }

  it { expect(described_class.new(input).calculate).to eq(8) }

  let(:input2) { '2 + 2 * 2 * 2 * 2' }

  it { expect(described_class.new(input2).calculate).to eq(32) }

  let(:input3) { '2 + (2 * 2)' }

  it { expect(described_class.new(input3).calculate).to eq(6) }

  let(:input4) { '1 + (2 * 3) + (4 * (5 + 6))' }

  it { expect(described_class.new(input4).calculate).to eq(51) }

  let(:input5) { '((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2' }

  it { expect(described_class.new(input5).calculate).to eq(13_632) }

  let(:input6) { '5 + (8 * 3 + 9 + 3 * 4 * 3)' }

  it { expect(described_class.new(input6).calculate).to eq(437) }

  describe '#calculate2' do
    let(:input6) { '5 + (8 * 3 + 9 + 3 * 4 * 3)' }

    it { expect(described_class.new(input6).calculate2).to eq(1445) }

    let(:input7) { '5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))' }

    it { expect(described_class.new(input7).calculate2).to eq(669060) }
  end
end
