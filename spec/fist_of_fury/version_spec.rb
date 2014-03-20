require 'spec_helper'

describe FistOfFury do
  it 'has a version' do
    expect(FistOfFury::VERSION).to_not be_nil
  end

  it 'has a version that matches the version in the README' do
    readme_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'README.md'))
    readme = File.read(readme_path)
    readme_matches = readme.scan(/gem 'fist_of_fury', '~> (\d+).(\d+).+'/)
    readme_matches
    readme_major = readme_matches[0][0]
    readme_minor = readme_matches[0][1]

    version_matches = FistOfFury::VERSION.scan(/(\d+).(\d+).+/)
    version_major = version_matches[0][0]
    version_minor = version_matches[0][1]

    expect(readme_major).to eq(version_major)
    expect(readme_minor).to eq(version_minor)
  end
end
