require "spec_helper"


describe Stormy::Engines::Sass do

  let(:app) { StormyApp.new({ root: FIXTURE_ROOT + "/dummy_site/" }) }
  let(:engine) { Stormy::Engines::Sass.new(app) }

  let(:body) do
    <<-DOC
.stuff {
  .interior { color:red; }
}
    DOC
  end

  context "#render" do
    it "renders sass" do
      result = engine.render(body,{})
      expect(result).to include(".stuff .interior")
    end
  end

end
