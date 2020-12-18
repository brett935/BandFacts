# spec/models/search_spec.rb
require 'rails_helper'

RSpec.describe Search, :type => :model do
  it "is valid with valid attributes" do
    search = Search.new(
        searched_name: "coldplay",
        success: true,
        response: {}
    )
    expect(search).to be_valid
  end

  it "is invalid without attributes" do
    expect(Search.new()).to_not be_valid
  end

  it "is not valid without a search_name" do
    search = Search.new(
        searched_name: nil,
        success: true,
        response: {})
    expect(search).to_not be_valid
  end

  it "is not valid without a 200 status (success)" do
    search = Search.new(
        searched_name: "coldplay",
        success: nil,
        response: {})
    expect(search).to_not be_valid
  end
  
  it "is not valid without a response" do
    search = Search.new(
        searched_name: "coldplay",
        success: false,
        response: nil)
    expect(search).to_not be_valid
  end
end