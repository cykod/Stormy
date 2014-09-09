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

    it "returns an image if it's an asset" do
      result = server.call("PATH_INFO" => "/assets/storm.jpg")
      expect(result[0]).to eq 200
      expect(result[1]["Content-Type"]).to eq "image/jpeg"
    end

    it "renders a custom 404 page" do
      custom_server = StormyServer.new(root: FIXTURE_ROOT + "/dummy_site/",
                                       page_not_found: "/missing")
      result = custom_server.call("PATH_INFO" => "/asgddasgasgsafd")
      expect(result[0]).to eq 404
      expect(result[2][0]).to include "Missing Page Yo!"

    end

  end
end
