# frozen_string_literal: true

require 'test/unit'
require 'jekyll'

class TestBlogPosts < Test::Unit::TestCase
  def test_authorship
    # Load all of the blog post md files, and fill the list of post authors
    post_authors = []
    Dir.foreach('_posts/') do |f|
      next if f.start_with?('.')

      yaml = get_front_matter("_posts/#{f}")
      assert_not_nil(yaml, "#{f} does not contain YAML front matter")
      assert_not_nil(yaml['author'], "#{f} does not contain an author")
      post_authors << yaml['author']
    end

    # Load all of the member profiles
    members = {}
    Dir.foreach('_collections/members/') do |f|
      next if f.start_with?('.', '_')

      yaml = get_front_matter("_collections/members/#{f}")
      assert_not_nil(yaml, "#{f} does not contain YAML front matter")
      assert_not_nil(yaml['name'], "#{f} does not contain a name")
      author_name = f.sub!(/\.md/, '')
      members[author_name] = yaml['name']
    end

    # Make sure that the authors each have a member page.
    post_authors.each do |author|
      assert(
        members.key?(author) || !members.value?(author),
        "#{author} already has a member profile. Please use the username associated with this member."
      )
    end
  end

  def get_front_matter(filename)
    file_contents = File.read(filename)
    if file_contents =~ Jekyll::Document::YAML_FRONT_MATTER_REGEXP
      data = SafeYAML.load(Regexp.last_match(1))
      return data
    end

    nil
  end
end
