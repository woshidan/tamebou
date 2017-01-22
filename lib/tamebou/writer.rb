module Tamebou
  class Writer
    module DefaultTemplate
      MINITEST = 1
      RSPEC = 2
    end

    def initialize(path, template_path=DefaultTemplate::MINITEST, is_warning_parse_failure=false)
      @template_path = case template_path
      when DefaultTemplate::MINITEST
        File.join(File.dirname(__FILE__), '../templates/minitest.txt.erb')
      when DefaultTemplate::RSPEC
        File.join(File.dirname(__FILE__), '../templates/rspec.txt.erb')
      else
        template_path
      end
      @is_warning_parse_failure = is_warning_parse_failure
      @path = path
      set_model_name
    end

    def write
      begin
        File.open(@path) do |file|
          file.each_line do |line|
            parse_result = Parser.parse(line)

            if parse_result.nil?
              warning_parse_failure line if @is_warning_parse_failure
              next
            end

            @field_name = parse_result[:field_name]

            unless parse_result[:options].is_a? Hash
              warning_parse_options_failure parse_result if @is_warning_parse_failure
              @option_name = "unknown"
              @helper = Module.const_get("Tamebou::Helpers::Base").send(:new, {})
              print_test_code
              next
            end

            parse_result[:options].each do |option_name, option_value|
              @option_name = option_name
              helper_class_name = option_name.capitalize
              @helper = begin
                Module.const_get("Tamebou::Helpers::#{helper_class_name}").send(:new, option_value)
              rescue NoMethodError, NameError => e
                warning_not_found_helper if @is_warning_parse_failure
                Module.const_get("Tamebou::Helpers::Base").send(:new, option_value)
              end
              print_test_code
            end
          end
        end
      rescue Exception => e
        puts e
      end
    end

    def set_model_name
      @model_name_in_snake_case = @path.match(/\/([^\/]+).rb$/)[1]
      @model_name = @model_name_in_snake_case.split("_").map{|w| w[0] = w[0].upcase; w}.join
    end

    def print_test_code
      puts "============================================="
      erb = ::ERB.new(File.read(@template_path))
      puts erb.result(binding)
      puts "============================================="
    end

    private
      def warning_parse_failure(line)
        puts "sorry, I cannot find validation in the next line : #{line}"
      end

      def warning_parse_options_failure(parse_result)
        puts "#{parse_result} cannot parse options. please validate options in single line. tamebou use base helper."
      end

      def warning_not_found_helper
        puts "its own helper not found. so tamebou use base helper."
      end
  end
end
