module Jekyll
    class Collection
        def relative_directory
            @relative_directory ||= metadata['relative_directory'] || "_#{label}"
        end
    end
end