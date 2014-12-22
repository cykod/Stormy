require "spec_helper"

shared_examples "a stormy cache" do 

  let(:app) {  StormyApp.new(root: FIXTURE_ROOT + "/dummy_site/",
                             cache: described_class.new) }

  context "#page" do

    it "stores returns the item in the block" do
      result = app.cache.page("tester") do
        "My Val"
      end

      expect(result).to eq "My Val"
    end

    it "doesn't call the block after it's stored it in the cache" do
      app.cache.page("tester") do
        "Dummy Val"
      end

      result = app.cache.page("tester") do
        raise "Error"
      end

      expect(result).to eq "Dummy Val"
    end
    
  end
end

describe Stormy::Caches::MemoryCache do
  it_behaves_like "a stormy cache"
end

describe Stormy::Caches::FileCache do
  it_behaves_like "a stormy cache"

  it "creates the necessary directory" do
    cache_dir = FIXTURE_ROOT + "/dummy_site/tmp/cache"
    FileUtils.rm_r(cache_dir) rescue nil

    expect(File.directory?(cache_dir)).to eq false
    app = StormyApp.new(root: FIXTURE_ROOT + "/dummy_site/",
                  cache: Stormy::Caches::FileCache.new)
    app.cache

    expect(File.directory?(cache_dir)).to eq true
  end
end
