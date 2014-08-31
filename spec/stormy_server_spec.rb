require "spec_helper"

describe StormyServer do

  let(:server) { StormyServer.new(root: FIXTURE_ROOT + "/dummy_site/") }

  describe "#call" do

    it "returns 404 with an invalid page" do
      result = server.call("PATH_INFO" => "/afdsa")
      expect(result[0]).to eq 404
    end

    it "returns a 200 with a valid page and valid layout" do
      expect {
        server.call("PATH_INFO" => "/tester_invalid_layout")
      }. to raise_error
    end

    it "returns a 200 with a valid page and valid layout" do
      result = server.call("PATH_INFO" => "/tester")
      expect(result[0]).to eq 200
    end

  end
end
