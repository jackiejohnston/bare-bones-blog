json.array!(@posts) do |post|
  json.extract! post, :headline, :slug, :intro, :article
  json.url post_url(post, format: :json)
end
