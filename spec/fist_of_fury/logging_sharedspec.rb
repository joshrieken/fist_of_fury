require 'spec_helper'

shared_examples_for 'a logger' do
  [:fatal, :error, :warn, :info, :debug].each do |level|
    it "responds to :#{level}" do
      expect(subject).to respond_to(level)
    end
  end
end
