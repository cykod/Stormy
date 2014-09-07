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

    it "resolves a content list" do
      page = app.page("blog")
      page.resolve_content
      expect(page.content[:blog].length).to eq 2
      expect(page.content[:blog][0][:title]).to eq "Super post"
      expect(page.content[:blog][1][:title]).to eq "Super post 2"
    end

    it "correctly orders a content list" do
      page = app.page("blog_desc")
      page.resolve_content
      expect(page.content[:blog].length).to eq 2
      expect(page.content[:blog][0][:title]).to eq "Super post 2"
      expect(page.content[:blog][1][:title]).to eq "Super post"
    end
  end

end
