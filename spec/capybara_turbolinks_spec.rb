require 'spec_helper'

describe CapybaraTurbolinks, type: :feature do
  it 'has a version number' do
    expect(CapybaraTurbolinks::VERSION).not_to be nil
  end

  it 'defines the additional methods' do
    expect(defined?(visit)).to be_truthy
    expect(Capybara::Node::Base.instance_methods).to include(:click_turbolink)
    expect(Capybara::Node::Element.instance_methods).to include(:turboclick)
    expect(defined?(click_turbolink)).to be_truthy
  end
end
