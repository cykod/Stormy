require "spec_helper"

describe Stormy::Stores::FileStore do

  class DummyStore < Stormy::Stores::Base

    def page(key); fake(key); end
    def layou(key); fake(key); end
    def content(category,key); fake(key); end
    def content_list(category,options); fake(category); end

    def fake(key)
      extract(key, "Fake Body Yo")
    end
  end

  let!(:store) { 
    Stormy::Stores::FallbackStore.new(
      Stormy::Stores::FileStore.new,
      DummyStore.new
    )
  }


  let!(:app) { StormyApp.new(root: FIXTURE_ROOT + "/dummy_site",
                             store: store ) }


  describe "#page" do
    it "returns a valid page from the file store" do
      details = store.page("tester")
      expect(details[:path]).to include("tester.haml")
      expect(details[:title]).to eq "The Testerama"
      expect(details[:key]).to eq "tester"
      expect(details[:body]).to include "Tester"
    end

    it "returns the fake page on an invalid page" do 
      details = store.page("tester_faker")
    end
  end

  describe "#layout" do
    it "returns a layout" do
      details = store.layout('main')
      expect(details[:permalink]).to eq "main"
    end
  end

  describe "#content" do
    it "returns a pieces of content" do
      details = store.content("blog","blog-post-1")
      expect(details[:title]).to eq "Super post"
    end
  end

  describe "#content_list" do
    it "returns a list" do
      details = store.content_list('blog',{ order: 'name' })
      expect(details[0][:title]).to eq "Super post"
    end
  end
end
