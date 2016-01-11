require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:link) do
    Link.new(url: "http://validurl.com", title: "validtitle")
  end

  it "is valid" do
    expect(link).to be_valid
  end

  it "is invalid with out an title" do
    link.title = nil
    expect(link).not_to be_valid
  end

  it "is invalid without a url" do
    link.url = nil
    expect(link).not_to be_valid
  end

  it "is invalid without a valid url" do
    link.url = "lkjasdf"
    expect(link).not_to be_valid
  end
end
