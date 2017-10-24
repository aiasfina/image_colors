require "./image_colors/*"
require "kemal"

get "/" do
  render "src/views/index.html.ecr", "src/views/layouts/layout.ecr"
end

Kemal.run(8080)
