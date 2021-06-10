# frozen_string_literal: true

module Jekyll
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      process(@name)
      read_yaml(File.join(base, '_layouts'), 'tag.html')
      data['tag'] = tag
      tag_title_prefix = site.config['tag_title_prefix'] || 'Posts Tagged &ldquo;'
      tag_title_suffix = site.config['tag_title_suffix'] || '&rdquo;'
      data['title'] = "#{tag_title_prefix}#{tag}#{tag_title_suffix}"
    end
  end

  class TagGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'tag'
        dir = site.config['tags_dir'] || 'tag'
        site.tags.each_key do |tag|
          write_tag_index(site, File.join(dir, tag), tag)
        end
      end
    end

    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end
