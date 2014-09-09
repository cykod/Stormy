require "spec_helper"


describe Stormy::Engines::Erb do

  let(:app) { StormyApp.new({ root: FIXTURE_ROOT + "/dummy_site/" }) }
  let(:engine) { Stormy::Engines::Erb.new(app) }

  let(:body) do
    <<-DOC
The answer is <%= 1+2 %>.
The word is <%= meta[:title] %>
    DOC
  end

  context "#render" do
    it "renders erbs" do
      result = engine.render(body,{ meta: { title: "Yay!" }})
      expect(result).to include "The answer is 3"
      expect(result).to include "The word is Yay!"
    end
  end

end
