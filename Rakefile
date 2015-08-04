require "rubygems"
require "bundler/setup"
require "stringex"
require "jekyll"
require "yaml"
require "cgi"

# based off octopress rakefile: https://github.com/imathis/octopress/blob/master/Rakefile
# rake -T to see tasks
# rake new_post['title']
# rake categories
# rake tags
# rake build == [categories, tags]
# rake get_handle['author'] to get the handle

## -- Misc Configs -- ##
$BASE_DIR       = "." # directory all others are relative to
$TEMPLATE_DIR   = "_templates"
posts_dir       = "_posts"
page_dir        = "."
$PREFERRED_EXT  = "md"
category_dir    = "generated/category"
tag_dir         = "generated/tag"
author_dir      = "generated/author"
dateindex_dir   = "generated/date"
feed_dir        = "generated/feeds"

new_page_template = "page.md"
rss_category_template = "rss.category.xml"
new_post_template = "post.md"
category_index_template = "category_index.md"
tag_index_template = "tag_index.md"
year_index_template = "year_index.md"
month_index_template = "month_index.md"
author_index_template = "author_index.md"

config_yml      = "_config.yml"

# usage: rake new_post
desc "Begin a new post."
task :new_post do |t, args|
  title = get_stdin("Enter a title for your post: ")
  filename = task_start(posts_dir, title.to_url, type="new post")
  open(filename, 'w') do |post|
    post.puts template_sub(new_post_template,
                           {'title' => CGI.escapeHTML(title),
                            'date'  => Time.now.strftime('%Y-%m-%d %H:%M:%S %z')})
  end
end

# usage: rake new_page
desc "Begin a new page."
task :new_page do |t, args|
  title = get_stdin("Enter a title for your page: ")
  filename = task_start(page_dir, title.to_url, type="new post")
  open(filename, 'w') do |page|
    page.puts template_sub(new_page_template,
                           {'title' => CGI.escapeHTML(title),
                            'handle' => get_handle(title),
                            'date'  => Time.now.strftime('%Y-%m-%d %H:%M:%S %z')})
  end
end

# usage: rake categories to generate category index (category/<category>)
desc "Generate category pages into #{$BASE_DIR}/#{category_dir}/"
task :categories do
  puts "Generating category pages..."

  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  site.categories.sort.each do |category, posts|
    filename = task_start(category_dir, category, type="category index page", check_exists=false, extension='html')
    open(filename, 'w') do |page|
      page.puts template_sub(category_index_template,
                             {'category' => category})
    end
  end
end

# usage: rake tags to generate tag index (tag/<tag>)
desc "Generate tag pages into #{$BASE_DIR}/#{tag_dir}/"
task :tags do
  puts "Generating tag pages..."

  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  site.tags.sort.each do |tag, posts|
    filename = task_start(tag_dir, tag, type="tag index page", check_exists=false, extension='html')
    open(filename, 'w') do |page|
      page.puts template_sub(tag_index_template,
                             {'tag' => tag})
    end
  end
end

# usage: rake dateindex to generate year/month index.
desc "Generate year and year/month indices in #{$BASE_DIR}/#{dateindex_dir}"
task :dateindex do
  puts "Generating date index pages..."

  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  h = site.posts.group_by { |p| p.date.year }
  h = h.merge(h) { | key, val| val.group_by{ |p| p.date.strftime('%m') } }
  h.each do |year, ppy|
    filename = task_start(dateindex_dir, year, type="year index page", check_exists=false, extension="html")
    open(filename, 'w') do |page|
      page.puts template_sub(year_index_template,
                             {'year' => year})
    end
    ppy.each do |month, pp|
      monyear = pp[0].date.strftime('%B %Y')
      filename = task_start("#{dateindex_dir}/#{year}", month, type="month index page", check_exists=false, extension="html")
      open(filename, 'w') do |page|
          page.puts template_sub(month_index_template,
                                 {'year' => year,
                                  'month' => month,
                                  'monyear' => monyear})
      end
    end # month
  end # year
end

# usage: rake authors to generate author index (author/<author>)
desc "Generate author indices into #{$BASE_DIR}/#{author_dir}/"
task :authors do
  puts "Generating author pages..."
  config = YAML::load_file(config_yml)

  config['authors'].each do |key, authorhash|
    author = authorhash['display_name']
    handle = authorhash['handle'] || get_handle(author)
    filename = task_start(author_dir, handle, type="author index page", check_exists=false, extension="html")
    open(filename, 'w') do |page|
      page.puts template_sub(author_index_template,
                             {'author' => author,
                              'handle' => handle,
                              'key' => key})
    end
  end
end

# --- UPTO

# Makes an rss feed per category (TODO: blogspot does by label...)
# blogspot does by label, e.g.
# http://mathematicalcoffee.blogspot.com/feeds/posts/default/-/gnome-shell-extension
desc "Generate per-category RSS feeds into #{$BASE_DIR}/#{feed_dir}/"
task :rss do
  puts "Generating RSS category pages..."

  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  site.categories.sort.each do |category, posts|
    filename = task_start(feed_dir, "rss.#{category}", type="RSS feed", check_exists=false, extension="xml")
    open(filename, 'w') do |page|
      page.puts template_sub(rss_category_template, {'category' => category})
    end
  end
end

desc "Generate author, dateindex (year, year/month), category, tag indices and rss feeds"
task :generate => [:authors, :dateindex, :tags, :categories, :rss] do
  puts "Indices generated."
end

desc "Tells you the handle for a given string (e.g. author). Usage rake handleize['John Doe']"
# usage: rake handleize['John Doe'] to get john-doe
task :handleize, :content do |t, args|
  if args.content
    content = args.content
  else
    content = get_stdin("Enter the string to handleize: ")
  end
  puts get_handle(content)
end

desc "Checks the blog"
task :check do
    # check that all authors have an entry
  config = YAML::load_file(config_yml)
  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  # check that all post authors are in site.authors
  puts "Checking that all post authors are in site.authors..."
  post_authors = site.posts.map{ |p| p.data['authors'] }.flatten.uniq.compact
  config_authors = config['authors'].keys.compact
  raise ("### The following post authors are not in #{config_yml}'s 'authors' key:\n    " +
         (post_authors - config_authors).join(', ') +
        "\nYou can use `rake add_author` to generate a template to include into #{config_yml}.\n\n") unless
  (post_authors - config_authors).empty?

  # check that all post authors have display_name and handle
  puts "Checking that all authors have display_name and a handle..."
  config['authors'].each do |k, author|
      raise "### Author with key '#{k}' has no display_name, add one in #{config_yml}.\n\n" unless author['display_name']
      h = get_handle(author['display_name'])
      raise "### Author '#{author['display_name']}' has no handle, use 'handle: #{h}' in #{config_yml}\n\n" unless author['handle']
      raise "### Author '#{author['display_name']}' should have handle '#{h}', not '#{author['handle']}'\n\n" unless author['handle'] == h
  end

  puts "Done."
end

desc "Adds an author to _config.yml. Usage: rake add_author"
task :add_author do
  display_name = get_stdin("The author's full/display name (e.g. John Doe): ")
  nick = get_stdin("Enter a one-word name to refer to this author in the author part of a post's frontmatter (e.g. john): ")
  handle = get_handle(display_name)

  author = YAML::load_file('_data/_author.yml')
  author['display_name'] = display_name
  author['handle'] = handle
  puts "COPY-PASTE the following into the 'authors' part of #{config_yml} and edit further."
  puts YAML::dump({nick => author})
end

desc "Refreshes 'updated' field of post frontmatter to the current time."
task :edit_post do
  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  puts "Which post to edit? "

  msg = site.posts.each_with_index.map{ |post, i|
      "[#{i + 1}] #{post.date.strftime('%Y-%m-%d')} #{post.title}" }
  answer = ask("Which post do you wish to edit?\n" + msg.join("\n") + "\n",
               (1..site.posts.size).map{|i| i.to_s})
  post = site.posts[answer.to_i - 1]
  cont = File.readlines(post.path)
  frontm = (0..cont.size).select{ |i| cont[i] =~ /^--- *$/ }
  rest   = cont[(frontm[1] + 1)..-1]
  frontm = cont[frontm[0]..frontm[1]]

  if frontm.size >= 2
    i = (0..frontm.size).select{ |i| frontm[i] =~ /^ *updated *:/ }
    str = 'updated: ' + Time.now.strftime('%Y-%m-%d %H:%M:%S %z')
    if i.size > 0
        frontm[i[0]] = str
    else
        frontm.insert(frontm.size - 1, str)
    end
  end

  # write back out
  open(post.path, 'w') do |page|
      page.puts frontm
      page.puts rest
  end
  puts "Added field \"#{str}\" to frontmatter of #{post.path}."
  puts "Done."
end

desc "Cleans, checks the blog's metadata, and generates post indices."
task :build => [:clean, :check, :generate] do
    puts "Done. Use (e.g.) bundle exec jekyll serve --watch"
end

desc "Clean"
task :clean do
  rm_rf ["generated"]
end

def get_handle(content)
  content.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
end

## From Octopress Rakefile
def get_stdin(message)
  print message
  STDIN.gets.chomp
end

def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def template_sub(template, dict)
    #string.gsub(/%\{([a-zA-Z_0-9]+)\}/) do |m| dict["#{$1}"] end
    IO.read("#{$TEMPLATE_DIR}/#{template}").gsub(/%\{([a-zA-Z_0-9]+)\}/) do |m| dict["#{$1}"] end
end

def task_start(directory, filename, type="new page", check_exists=true, extension=nil)
  raise "### Could not find the source directory.\n\n" unless File.directory?($BASE_DIR)
  mkdir_p "#{$BASE_DIR}/#{directory}", :verbose => false
  ext = extension.nil? ? $PREFFERED_EXT : extension
  filename = "#{$BASE_DIR}/#{directory}/#{filename}.#{ext}"
  if check_exists and File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating #{type}: #{filename}"
  return filename
end
