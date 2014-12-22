require "spec_helper"


describe Stormy::Engines::Html do

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

end
