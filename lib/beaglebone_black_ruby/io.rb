module BeagleboneBlackRuby
  module IO

    def file_directory_path
      raise "#{__method__} method must be implemented in the class including this module"
    end

    def write_to_io_file(filename, value)
      FileUtils.mkdir_p(file_directory_path, mode: 0700) unless Dir.exists?(file_directory_path)
      file_path = File.join(file_directory_path, filename)
      
      open(file_path, "w").write(value) 
    end    

  end
end