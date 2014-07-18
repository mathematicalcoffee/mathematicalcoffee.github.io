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
dateindex_dir   = "generated/date"

# usage: rake new_post[my-new-post] or rake new_post['my new post'] or rake new_post (defaults to "new-post")
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

# usage: rake categories to generate category index (category/<category>)
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
      page.write "  {% for post in site.categories.#{category} %}"
      page.write "    {% include post-short.html %}"
      page.write "  {% endfor %}"
      page.puts "</ul>"
    end
  end
end

# usage: rake tags to generate tag index (tag/<tag>)
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
      page.write "  {% for post in site.tags.#{tag} %}"
      page.write "    {% include post-short.html %}"
      page.write "  {% endfor %}"
      page.puts "</ul>"
    end
  end
end

# usage: rake dateindex to generate year/month index.
desc "Generate year and year/month indices in #{source_dir}/#{dateindex_dir}"
task :dateindex do
  raise "### Could not find the source directory." unless File.directory?(source_dir)
  mkdir_p "#{source_dir}/#{dateindex_dir}"
  puts "Generating date index pages..."

  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  h = site.posts.group_by { |p| p.date.year }
  h = h.merge(h) { | key, val| val.group_by{ |p| p.date.strftime('%m') } }
  h.each do |year, ppy|
    mkdir_p "#{source_dir}/#{dateindex_dir}/#{year}"
    filename="#{source_dir}/#{dateindex_dir}/#{year}.html"
    puts "Creating page: #{filename}"
    open(filename, 'w') do |page|
      page.puts  "---"
      page.puts  "layout: default"
      page.puts  "title: Posts for #{year}"
      page.puts  "permalink: /#{year}/"
      page.puts  "---"
      page.puts  "<ul>"
      page.write "{% for post in site.posts %}"
      page.write "  {% assign y=post.date | date: '%Y' %}"
      page.write "    {% if y == '#{year}' %}"
      page.write "      {% capture currentmonth %}{{post.date | date: '%B'}}{% endcapture %}"
      page.write "      {% if currentmonth != month %}"
      page.write "        {% unless forloop.first %}"
      page.write "  </li></ul>{% endunless %}"
      page.write "  <li><a href=\"/#{year}/{{ post.date | date: '%m'}}/\">{{ currentmonth }}</a>"
      page.write "    <ul>"
      page.write "          {% capture month %}{{currentmonth}}{% endcapture %} "
      page.write "      {% endif %}"
      page.write "            {% include post-short.html %}"
      page.write "    {% endif %}"
      page.write "{% endfor %}"
      page.puts  "</ul>"
    end

    ppy.each do |month, pp|
      filename="#{source_dir}/#{dateindex_dir}/#{year}/#{month}.html"
      puts "Creating page: #{filename}"
      monyear = pp[0].date.strftime('%B %Y')
      open(filename, 'w') do |page|
        page.puts "---"
        page.puts "layout: default"
        page.puts "title: Posts for #{monyear}"
        page.puts "permalink: /#{year}/#{month}/"
        page.puts "---"
        page.puts "<ul>"
        page.write "  {% for post in site.posts %}"
        page.write "    {% assign my=post.date | date: '%B %Y' %}"
        page.write "      {% if my == '#{monyear}' %}"
        page.write "        {% include post-short.html %}"
        page.write "      {% endif %}"
        page.write "  {% endfor %}"
        page.puts "</ul>"
      end
    end # month
  end # year
end

# usage: rake authors to generate author index (author/<author>)
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
      page.write "{% assign c=0 %}"
      page.write "{% for post in site.posts %}"
      page.write "  {% if post.authors and post.authors contains '#{key}' %}"
      page.write "    {% assign c=c | plus:1 %}"
      page.write "  {% endif %}"
      page.write "{% endfor %}"
      page.write "{% if c > 0 %}"
      page.write "<p><ul>"
      page.write "  {% for post in site.posts %}"
      page.write "    {% if post.authors and post.authors contains '#{key}' %}"
      page.write "      {% include post-short.html %}"
      page.write "    {% endif %}"
      page.write "  {% endfor %}"
      page.write "</ul></p>"
      page.write "{% else %}"
      page.write "<p>No posts by this author.</p>"
      page.write "{% endif %}"
    end
  end
end

desc "Clean"
task :clean do
  rm_rf ["generated"]
end
