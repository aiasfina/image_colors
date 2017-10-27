require "./image_colors/*"
require "json"
require "kemal"

public_folder ::File.join [File.expand_path(__DIR__), "public"]

get "/" do
  render "src/views/index.html.ecr", "src/views/layouts/layout.ecr"
end

post "/upload" do |env|
  env.response.content_type = "application/json"
  file = env.params.files["file"]
  result = ImageColors::Utils.convert_histogram_info(file.tmpfile.path)
  JSON.build do |json|
    json.array do
      result.each do |item|
        json.object do
          json.field "score", item[:score]
          json.field "rgba", item[:rgba].join(",")
          json.field "hex", item[:hex]
        end
      end
    end
  end
end

Kemal.run(8080)
