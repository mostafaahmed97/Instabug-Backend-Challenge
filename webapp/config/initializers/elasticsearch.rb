es_url = "http://#{ENV['ES_HOST']}:#{ENV['ES_PORT']}"

Elasticsearch::Model.client = Elasticsearch::Client.new(
  log:true,
  url: "http://elasticsearch:9200"
)