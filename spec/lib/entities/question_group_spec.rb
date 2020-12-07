# frozen_string_literal: true

describe Entities::QuestionGroup do
  describe '#total_questions_answered' do
    let(:line) do
      <<~QUE
        a
        b
        c
      QUE
    end

    it { expect(described_class.new(line).total_questions_answered).to eq(3) }

    context 'when non-uniq chars' do
      let(:line) do
        <<~QUE
          a
          a
          a
          a
        QUE
      end

      it { expect(described_class.new(line).total_questions_answered).to eq(1) }
    end
  end

  describe '#questions_answered_by_all_people' do
    let(:line) do
      <<~QUE
        a
        b
        c
      QUE
    end

    it { expect(described_class.new(line).questions_answered_by_all_people).to eq(0) }

    context 'when non-uniq chars' do
      let(:line) do
        <<~QUE
          a
          a
          a
          a
        QUE
      end

      it { expect(described_class.new(line).questions_answered_by_all_people).to eq(1) }
    end
  end
end
