# Stormy 

> While Frank Sinatra sings "Stormy Weather" The flies and spiders get along together. 
> Cobwebs fall on an old skipping record. 
>    - Cake


[![Code Climate](https://codeclimate.com/github/cykod/Stormy/badges/gpa.svg)](https://codeclimate.com/github/cykod/Stormy)
[![Test Coverage](https://codeclimate.com/github/cykod/Stormy/badges/coverage.svg)](https://codeclimate.com/github/cykod/Stormy)

A not-ready-for-primetime Opinionated semi-static CMS/Site Builder designed for simplicity and flexibility.

## Why Stormy?

Frameworks like Rails and Django are great, but they are a lot of code to drag around for small projects. Stop paying attention to a half-dozen side projects for a few months and suddenly the API has changed underneath you and you've got to spend all your time just to keep your projects update to date instead of having fun building stuff.

Static site generators like Jekyll are great, but sometimes you still want to run some code on each request - just not enough to justify a full MVC.

Imagine writing some Ruby like it was a simple PHP site - a little markup here, some code there, all stuck together without any config or setup.

## PHP is your model, Really?

Again, Frameworks are great, but if you've ever tried teaching someone new to web development a Framework, it's a lot to take in. Just getting everything set up and configued (what do you mean you can't connect to the database, is Postgres event running? What do you mean you don't know?) is a multi-step affair.

Imagine you could just start writing code in your favorite languages (provided your favorite languages are Ruby, HAML, and Sass) and not worry about the other stuff. Wouldn't that be great? Imagine your could deploy your running app to Heroku without configuring jack squat.

That's the goal of Stormy - a simple, minimal-dependency semi-static rack-based app server that throws away all the best practices we've been using for the past decade.

## Why didn't you just use [INSERT MICRO-FRAMEWORK HERE]?

Dammit, I should have - you're right. Oh well.

## How to use

### Basics

Shell scripts coming soon - for now, put Stormy in your Gemfile, bundle and then create a config.ru
 
    require "stormy"
    run StormyServer.new( root:  File.dirname(__FILE__) )

Create a `/public` directory and put directories and files ending in .md, .haml, .scss or .html in it along with any of your static assets. 

Run:

    rackup

Your site should now be live.

### Front Matter

... Documentation Forthcoming ...

### Content, Pagination and Blogs

... Documentation Forthcoming ...

### Redirects

... Documentation Forthcoming ...

### Permalinks 


