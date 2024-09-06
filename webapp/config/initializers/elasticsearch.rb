Elasticsearch::Model.client = Elasticsearch::Client.new(
  log:true,
  # TODO: replace with env var.
  url: "http://localhost:9200"
)