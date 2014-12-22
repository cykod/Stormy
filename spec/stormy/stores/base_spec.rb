require "spec_helper"

describe Stormy::Stores::Base do

  let!(:app) { StormyApp.new(root: FIXTURE_ROOT + "/dummy_site",
                             store: Stormy::Stores::FileStore ) }

  let!(:store) { Stormy::Stores::Base.new(app) }

  describe "#extract_content" do

    let(:valid_string) do
<<-EOF
---
thing: a
otherthing: b
---
Content
EOF
    end

    let(:invalid_string) do
<<-EOF
---
&*%^*
---
Content
EOF
    end


    it "raises an exception with bad yaml" do
      expect { 
        store.extract("something.txt",
                      invalid_string,
                      {})
      }.to raise_exception
    end

    context "valid string" do
      let(:details) { 
        store.extract("/ok/something.txt",
                      valid_string,
                      {})
      }

      it "extracts the front matter" do
        expect(details[:thing]).to eq "a"
        expect(details[:otherthing]).to eq "b"
      end

      it "returns the body" do
        expect(details[:body]).to eq "Content\n"
      end


      it "includes the permalink" do
        expect(details[:permalink]).to eq "something"
      end

      it "includes the full key" do
        expect(details[:key]).to eq "/ok/something.txt"
      end
    end


  end

end
