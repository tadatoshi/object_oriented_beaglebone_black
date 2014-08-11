require 'fileutils'

module BeagleboneBlackRuby
  module IO

    def file_directory_path
      raise "#{__method__} method must be implemented in the class including this module"
    end

    def write_to_io_file(filename, value)
      FileUtils.mkdir_p(file_directory_path, mode: 0700) unless Dir.exists?(file_directory_path)
      file_path = File.join(file_directory_path, filename)
      
      File.open(file_path, "w") do |file|
        file.write(value) 
      end
    end

    def read_from_io_file(filename)
      file_path = File.join(file_directory_path, filename)

      if File.exists?(file_path)
        file_content = nil
        # Using this instead of simple "File.open(file_path).read" in order to close file after reading. 
        File.open(file_path) do |file|
          file_content = file.read
        end
        file_content
      end

    end

  end
end