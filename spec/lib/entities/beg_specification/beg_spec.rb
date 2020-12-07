# frozen_string_literal: true

describe Entities::BegSpecification::Beg do
  let(:line) { 'bright white bags contain 1 shiny gold bag.' }

  it { expect(described_class.new(line).to_map).to eq('bright white' => [['1', 'shiny gold']]) }
end
