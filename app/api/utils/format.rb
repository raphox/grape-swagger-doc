module API
  module Utils
    class Format
      def self.prepare_documentation(entity)
        documentation = entity.documentation.clone

        documentation.each do |key, value|
          if value[:type].name.include?("Entities")
            type               = prepare_documentation(value[:type])
            documentation[key] = value[:is_array] ? [type] : type
          else
            type               = value[:type].name.downcase
            documentation[key] = value[:is_array] ? [type] : type
          end
        end

        documentation
      end

      def self.pretty_documentation(entity)
        documentation = prepare_documentation(entity)

        <<-NOTE
\n
\n~~~json
#{JSON.pretty_generate(documentation)}
~~~
NOTE
      end
    end
  end
end