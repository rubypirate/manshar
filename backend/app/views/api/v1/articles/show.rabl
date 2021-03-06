object @article

attributes :id, :title, :tagline, :created_at, :updated_at,
  :published, :recommendations_count, :comments_count

# TODO(mkhatib): This is only needed in listing to do the time to read.
# Maybe implement this in the backend instead of frontend.
attributes :body

# Don't return cover for listings. We only need these when we are getting the
# full article. This might change in the future but for now this is causing
# a lot of queries to be executed when listing articles.
unless locals[:listing]
  attribute :cover_abs_url => :original_cover_url

  node :thumb_url do |article|
    article.cover_abs_url '400x400#'
  end

  node :cover_url do |article|
    article.cover_abs_url '1900x1200#'
  end

  node :card_cover_url do |article|
    article.cover_abs_url '1140x270#'
  end
end

child :user do
	extends('api/v1/users/show', :locals => { :listing => locals[:listing] })
end
