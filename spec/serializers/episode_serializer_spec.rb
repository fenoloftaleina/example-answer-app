require 'rails_helper'

describe EpisodeSerializer do
  subject do
    EpisodeSerializer.new(object).serializable_hash.with_indifferent_access
  end

  let(:object) { build_stubbed(:episode) }

  equal_keys([:title, :episode])
end
