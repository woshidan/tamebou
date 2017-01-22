module Tamebou
  class Parser
    VALID_PATTERN = /\A\s*validates(\s+|\():([\w\d_]+)?/.freeze
    SINGLE_LINE_VALIDATION_PATTERN = /\A\s*validates(\s+|\():([\w\d_]+)?\s*,(.+)/.freeze
    FIELD_NAME_INDEX = 2
    OPTIONS_INDEX = 3

    def self.parse(line)
      valid_result = line.match(VALID_PATTERN)
      return nil if valid_result.nil?

      if supported_result = line.match(SINGLE_LINE_VALIDATION_PATTERN)
        options_in_str = supported_result[OPTIONS_INDEX]

        options = begin
          to_hash(options_in_str)
        rescue SyntaxError => e
          options_in_str
        end

        { field_name: supported_result[FIELD_NAME_INDEX], options: options }
      else
        { field_name: valid_result[FIELD_NAME_INDEX] }
      end
    end

    # refs. http://qiita.com/uplus_e10/items/65a50935250639bf8308
    # you should not use production code!
    private
      def self.to_hash(str)
        str.chop! if str.match(/\A[^\(].+\)\Z/)
        if str.match(/\A[^\(].+,\Z/)
          str.chop!
          str = str + "}"
        end
        str = "{#{str}}" unless str.match(/\A\s*\{.*?\}\s*\Z/)
        eval(str)
      end
  end
end
