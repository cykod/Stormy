require "spec_helper"

describe StormyApp do

  context "options" do

    it "raises an error without a root option set" do
      expect do
        StormyApp.new({})
      end.to raise_error

    end

    context "with root set" do
      let(:app) {  StormyApp.new(root: FIXTURE_ROOT + "/dummy_site/") }

      it "sets the root with a root set" do
        app = StormyApp.new(root: "/dummy_site")
        expect(app.root).to eq "/dummy_site"
      end

      it "creates a dummy cache by default" do
        expect(app.cache).to be_instance_of Stormy::Caches::DummyCache
      end

      it "creates a file store by default" do
        expect(app.store).to be_instance_of Stormy::Stores::FileStore
      end

      it "loads the defaults.yml file" do
        expect(app.defaults[:layout]).to eq "main"
      end
    end

  end

end
