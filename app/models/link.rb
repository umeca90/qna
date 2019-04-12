class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true
  validates :url, presence: true, url: true

  GIST_MASK = /^https:\/\/gist\.github\.com\/\w+\/\w+/i

  def gist_url_id
    gist_id = self.url.split('/').last
    result = GistService.new(gist_id).call
    result.files.to_hash.first[0]
  end

  def gist?
    self.url.match?(GIST_MASK)
  end
end
