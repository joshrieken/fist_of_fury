require 'spec_helper'

module ::Rails
  class Railtie
    def self.initializer(name)
    end
  end
end

require_relative '../../lib/fist_of_fury/railtie'

describe FistOfFury::Railtie do
  after :all do
    Object.send(:remove_const, :Rails)
  end

  it 'derives from ::Rails::Railtie' do
    expect(described_class.ancestors).to include(::Rails::Railtie)
  end
end
