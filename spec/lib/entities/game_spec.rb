# frozen_string_literal: true

describe Entities::Game do
  it { expect(described_class.new([0, 3, 6]).play).to eq(436) }
  it { expect(described_class.new([2, 15, 0, 9, 1, 20]).play).to eq(436) }
end
