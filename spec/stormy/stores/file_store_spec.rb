require "spec_helper"

describe Stormy::Stores::FileStore do


  let!(:app) { StormyApp.new(root: FIXTURE_ROOT + "/dummy_site",
                             store: Stormy::Stores::FileStore ) }
  let!(:store) { app.store }


  describe "#lookup_filename" do

    it "returns a filename even if the extension is missing" do
      file,meta = store.lookup_filename("public","tester")
      expect(file).to include  "tester.haml"
    end

    it "returns nil if we try to force the engine extension" do
      file,meta = store.lookup_filename("public","tester.haml")
      expect(file).to eq nil
    end

    it "returns the index file if the path is a directory" do
      file,meta = store.lookup_filename("public","subdir/")
      expect(file).to include "index.haml"
    end

    it "returns the index file without the trailing slash" do
      file,meta = store.lookup_filename("public","subdir")
      expect(file).to include "index.haml"
    end

    it "returns a file with path metadata" do
      file,meta = store.lookup_filename("public","pathtest/this-is-a-test")
      expect(file).to include ":permalink.haml"
    end
  end


  describe "#page" do
    it "returns a valid page in public and extracts the meta data" do
      details = store.page("tester")
      expect(details[:path]).to include("tester.haml")
      expect(details[:title]).to eq "The Testerama"
      expect(details[:key]).to eq "tester"
      expect(details[:body]).to include "Tester"
    end

    it "returns a segmented path with the valid meta data" do
      details = store.page("pathtest/this-is-a-test")
      expect(details[:path]).to include("permalink.haml")
      expect(details[:body]).to include "some random body copy"
      expect(details[:permalink]).to eq "this-is-a-test"
    end
  end

  describe "#content" do
    it "returns a pieces of content" do
      details = store.content("blog","blog-post-1")
      expect(details[:title]).to eq "Super post"
      expect(details[:author]).to eq "Svend Karlson"
      expect(details[:key]).to eq "blog-post-1"
    end
  end
  
end
