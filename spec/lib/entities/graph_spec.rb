# frozen_string_literal: true

describe Entities::Graph do
  subject { described_class.new(numbers).paths }

  let(:numbers) { [1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31, 32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 48, 49] }

  it { expect(subject).to eq(19_208) }

  context 'simplest' do
    let(:numbers) { [1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19] }

    it { expect(subject).to eq(8) }
  end
end
