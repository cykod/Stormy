require "spec_helper"

describe Stormy::Page do

  let!(:app) { StormyApp.new(root: FIXTURE_ROOT + "/dummy_site") }

  describe "#resolve_content" do

    it "resolves the content from the blog category for hardcoded content" do
      page = app.page("hardcoded_blog_post", {})
      page.resolve_content

      expect(page.content[:content][:title]).to eq "Super post"
      expect(page.content[:content][:author]).to eq "Svend Karlson"
      expect(page.content[:content][:body]).to include "This is the content of the blog post yo!"
    end

    it "resolves content from permalinks" do
      page = app.page("pathtest/blog-post-1", {})
      page.resolve_content
      expect(page.content[:post][:title]).to eq "Super post"
      expect(page.content[:post][:author]).to eq "Svend Karlson"
    end
  end

end
