require "spec_helper"


describe Stormy::Template do

  let(:app) { StormyApp.new({ root: FIXTURE_ROOT + "/dummy_site/" }) }
  let(:engine) { Stormy::Engines::Html.new(app) }

  let(:body) do
    "<div>Whoa!</div>"
  end

  context "#render" do
    it "renders erbs" do
      result = engine.render(body,{ meta: { title: "Yay!" }})
      expect(result).to eq "<div>Whoa!</div>"
    end
  end

  context ".extract_segment" do
    it "drops the extension of a rendered extension" do
      expect(Stormy::Template.extract_segment("tester.html.haml")).to eq "tester.html"
    end

    
    it "leaves the extension of a non-rendered extension" do
      expect(Stormy::Template.extract_segment("tester.agdas")).to eq "tester.agdas"
    end
    
  end
end
