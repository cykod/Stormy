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

    it "sets valid to false with invalid content" do
      page = app.page("bad_content")
      page.resolve_content
      expect(page.valid?).to eq false
    end

  end

  describe "#render" do
    it "renders the output of a page" do
      page = app.page("tester")
      output = page.render
      expect(output[0]).to eq 200
      expect(output[1]['Content-Type']).to eq "text/html"
      expect(output[2][0]).to include "Tester"
    end

    it "renders the output of content in a page" do
      page = app.page("blog")
      output = page.render
      expect(output[2][0]).to include "Svend Karlson"
      expect(output[2][0]).to include "Bob Johnson"
    end

    it "does a redirect if redirect is set in the page" do
      page = app.page("redirecto")
      output = page.render
      expect(output[0]).to eq 301
      expect(output[1]["Location"]).to eq "/tester"
    end

    it "can dynamicaly set the redirect from a path key" do
      page = app.page("redirects/something-awesome")
      output = page.render
      expect(output[0]).to eq 301
      expect(output[1]["Location"]).to eq "/new-location/something-awesome"
    end
  end

end
