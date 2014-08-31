require "spec_helper"

describe Stormy::Stores::FileStore do


  let!(:app) { StormyApp.new(root: FIXTURE_ROOT + "/dummy_site",
                             store: Stormy::Stores::FileStore ) }
  let!(:store) { app.store }


  describe "#filename" do

    it "returns a filename even if the extension is missing" do
      file,meta = store.filename("public","tester")
      expect(file).to include  "tester.haml"
    end

    it "returns nil if we try to force the engine extension" do
      file,meta = store.filename("public","tester.haml")
      expect(file).to eq nil
    end

    it "returns the index file if the path is a directory" do
      file,meta = store.filename("public","subdir/")
      expect(file).to include "index.haml"
    end

    it "returns the index file without the trailing slash" do
      file,meta = store.filename("public","subdir")
      expect(file).to include "index.haml"
    end

    it "returns a file with path metadata" do
      file,meta = store.filename("public","pathtest/this-is-a-test")
      expect(file).to include ":permalink.haml"
    end
  end


  describe "#page" do

    it "returns a valid page in public and extracts the meta data" do
      path, meta, content = store.page("tester")
      expect(path).to include("tester.haml")
      expect(meta[:title]).to eq "The Testerama"
      expect(content).to include "Tester"
    end

    it "returns a segmented path with the valid meta data" do
      path, meta, content = store.page("pathtest/this-is-a-test")
      expect(path).to include("permalink.haml")
      expect(content).to include "some random body copy"
      expect(meta[:permalink]).to eq "this-is-a-test"
    end
  end
  
end
