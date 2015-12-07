require 'rails_helper'

RSpec.describe BlogEntry, type: :model do
  before(:all) do
    @blog_entry = BlogEntry.new(title: 'My title', content: 'My content')
  end

  it 'should have a matching title' do
    expect(@blog_entry.title).to eq('My title')
  end

  it 'should have a matching content' do
    expect(@blog_entry.content).to eq('My content')
  end

end