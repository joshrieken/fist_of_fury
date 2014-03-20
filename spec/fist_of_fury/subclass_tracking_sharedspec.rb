require 'spec_helper'

shared_examples_for 'a class that tracks its subclasses' do
  class ClassThatTracksItsSubclasses < described_class
  end

  class AnotherClassThatTracksItsSubclasses < ClassThatTracksItsSubclasses
  end

  describe '#subclasses' do
    context 'when deep is specified' do
      it 'returns the class' do
        expect(described_class.subclasses()).to include(ClassThatTracksItsSubclasses)
        expect(described_class.subclasses(true)).to include(AnotherClassThatTracksItsSubclasses)
      end
    end

    context 'when deep is not specified' do
      it 'returns the class' do
        expect(described_class.subclasses(false)).to include(ClassThatTracksItsSubclasses)
        expect(described_class.subclasses(false)).not_to include(AnotherClassThatTracksItsSubclasses)
      end
    end
  end
end
