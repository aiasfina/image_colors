module ImageColors
  class Utils
    def self.upload_dir
      ::File.join [Kemal.config.public_folder, "uploads/"]
    end

    def self.upload_path(filename : String)
      ::File.join [upload_dir, filename]
    end

    def self.move_to_upload_dir(file : Kemal::FileUpload, filename : String | Nil)
      if !filename.is_a?(String)
        return p "No filename included in upload"
      else
        File.open(upload_path(filename), "w") do |f|
          IO.copy(file.tmpfile, f)
        end
      end
    end

    def self.convert_histogram_info(file_path : String, colors : String = "200")
      str = String.build do |io|
        # Process.run("convert", args: {file_path, "-define", "histogram:unique-colors=true", "-format", "%c", "histogram:info:-"}, output: io)
        Process.run("convert", args: {file_path, "-format", "%c", "-dither", "none", "-quantize", "YIQ", "-colors", colors, "-depth", "8", "histogram:info:-"}, output: io)
      end

      str.scan(/(?<score>\d+):\s\((?<rgba>.*?)\)\s(?<hex>#[0-9A-Z]+)/m).map do |meta|
        {score: meta["score"].to_i, rgba: meta["rgba"].gsub(/\s/, "").split(",").map { |s| s.to_i }, hex: meta["hex"]}
      end.sort_by { |h| h[:score] }.reverse
    end
  end
end
