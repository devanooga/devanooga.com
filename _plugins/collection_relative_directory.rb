module Jekyll
    class Collection
        def relative_directory
            @relative_directory ||= (metadata['relative_directory'] && site.in_source_dir(metadata['relative_directory']) || "_#{label}")
        end
    end
end