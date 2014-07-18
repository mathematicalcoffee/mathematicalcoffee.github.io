require "rubygems"
require "bundler/setup"
require "stringex"
require "jekyll"
require "yaml"

# based off octopress rakefile: https://github.com/imathis/octopress/blob/master/Rakefile
# rake -T to see tasks
# rake new_post['title']
# rake categories
# rake tags
# rake build == [categories, tags]

## -- Misc Configs -- ##
source_dir      = "."
posts_dir       = "_posts"
new_post_ext    = "md"
category_dir    = "generated/category"
tag_dir         = "generated/tag"
author_dir      = "generated/author"

# usage rake new_post[my-new-post] or rake new_post['my new post'] or rake new_post (defaults to "new-post")
desc "Begin a new post in #{source_dir}/#{posts_dir}"
task :new_post, :title do |t, args|
  if args.title
    title = args.title
  else
    title = get_stdin("Enter a title for your post: ")
  end
  raise "### Could not find the source directory." unless File.directory?(source_dir)
  mkdir_p "#{source_dir}/#{posts_dir}"
  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M:%S %z')}"
    post.puts "comments: true"
    post.puts "categories: "
    post.puts "tags: "
    post.puts "authors: "
    post.puts "---"
  end
end

# usage rake categories to generate category index (category/<category>)
desc "Generate category pages into #{source_dir}/#{category_dir}/"
task :categories do
  raise "### Could not find the source directory." unless File.directory?(source_dir)
  mkdir_p "#{source_dir}/#{category_dir}"
  puts "Generating category pages..."

  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  site.categories.sort.each do |category, posts|
    filename = "#{source_dir}/#{category_dir}/#{category}.html"
    puts "Creating page: #{filename}"
    open(filename, 'w') do |page|
      page.puts "---"
      page.puts "layout: default"
      page.puts "title: Posts in category \"#{category}\""
      page.puts "permalink: /category/#{category}/"
      page.puts "---"
      page.puts "<ul>"
      page.puts "  {% for post in site.categories.#{category} %}"
      page.puts "    {% include post-short.html %}"
      page.puts "  {% endfor %}"
      page.puts "</ul>"
    end
  end
end

# usage rake tags to generate tag index (tag/<tag>)
desc "Generate tag pages into #{source_dir}/#{tag_dir}/"
task :tags do
  raise "### Could not find the source directory." unless File.directory?(source_dir)
  mkdir_p "#{source_dir}/#{tag_dir}"
  puts "Generating tag pages..."

  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  site.tags.sort.each do |tag, posts|
    filename = "#{source_dir}/#{tag_dir}/#{tag}.html"
    puts "Creating page: #{filename}"
    open(filename, 'w') do |page|
      page.puts "---"
      page.puts "layout: default"
      page.puts "title: Posts tagged \"#{tag}\""
      page.puts "permalink: /tag/#{tag}/"
      page.puts "---"
      page.puts "<ul>"
      page.puts "  {% for post in site.tags.#{tag} %}"
      page.puts "    {% include post-short.html %}"
      page.puts "  {% endfor %}"
      page.puts "</ul>"
    end
  end
end

# usage rake authors to generate author index (author/<author>)
desc "Generate author pages into #{source_dir}/#{author_dir}/"
task :authors do
  raise "### Could not find the source directory." unless File.directory?(source_dir)
  mkdir_p "#{source_dir}/#{author_dir}"
  puts "Generating author pages..."
  config = YAML::load_file('_config.yml')

  config['authors'].each do |key, authorhash|
    author = authorhash['display_name']
    handle = author.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    filename = "#{source_dir}/#{author_dir}/#{handle}.html"
    puts "Creating page: #{filename}"
    open(filename, 'w') do |page|
      page.puts "---"
      page.puts "layout: default"
      page.puts "title: Posts written by #{author}"
      page.puts "permalink: /author/#{handle}/"
      page.puts "---"
      page.puts "{% assign c=0 %}"
      page.puts "{% for post in site.posts %}{% if post.authors and post.authors contains '#{key}' %}{% assign c=c | plus:1 %}{% endif %}{% endfor %}"
      page.puts "{% if c > 0 %}"
      page.puts "<p><ul>"
      page.puts "  {% for post in site.posts %}"
      page.puts "    {% if post.authors and post.authors contains '#{key}' %}"
      page.puts "      {% include post-short.html %}"
      page.puts "    {% endif %}"
      page.puts "  {% endfor %}"
      page.puts "</ul></p>"
      page.puts "{% else %}"
      page.puts "<p>No posts by this author.</p>"
      page.puts "{% endif %}"
    end
  end
end

desc "Clean"
task :clean do
  rm_rf ["generated"]
end
