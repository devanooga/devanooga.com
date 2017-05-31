require 'test/unit'
require 'jekyll'

class TestBlogPosts < Test::Unit::TestCase

  def test_authorship

    # Load all of the blog post md files, and fill the list of post authors
    post_authors = []
    Dir.foreach('_posts/') do |f|
      if f.chars[0] == '.'
        next
      end

      yaml = get_front_matter("_posts/#{f}")
      assert_not_nil(yaml)
      assert_not_nil(yaml['author'])
      post_authors << yaml['author']

    end

    # Load all of the member profiles
    members = {}
    Dir.foreach('_collections/members/') do |f|
      if f.chars[0] == '.' or f.chars[0] == '_'
        next
      end

      yaml = get_front_matter("_collections/members/#{f}")
      assert_not_nil(yaml)
      assert_not_nil(yaml['name'])
      author_name = f.sub!(/\.md/, '')
      members[author_name] = yaml['name']
    end

    # Make sure that the authors each have a member page.
    post_authors.each do |author|
      assert_true(members.key?(author) || !members.has_value?(author))
    end

  end

  def get_front_matter(filename)
    file_contents = File.read(filename)
    if file_contents =~ Jekyll::Document::YAML_FRONT_MATTER_REGEXP
      data = SafeYAML.load(Regexp.last_match(1))
      return data
    end

    return nil
  end

end
