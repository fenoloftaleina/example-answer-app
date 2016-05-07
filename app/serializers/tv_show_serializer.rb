class TvShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :rank, :created_at

  has_many :episodes

  def filter(keys)
    if object.association(:episodes).loaded?
      keys
    else
      keys - [:episodes]
    end
  end
end
