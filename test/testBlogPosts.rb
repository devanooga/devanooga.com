require 'test/unit'

class TestBlogPosts < Test::Unit::TestCase
  def test_authorship
    # TODO
    # Load all of the blog post md files
    # Load all of the member page md files
    # Compare the author field in each blog posts frontmatter to the member pages
    #   - If the author name matches a member's name, fail
    #   - The user should include their username as the author (if they are a member)
  end
end
