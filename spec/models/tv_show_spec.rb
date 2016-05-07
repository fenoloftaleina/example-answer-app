require 'rails_helper'

describe TvShow do
  it 'validates presence of title' do
    tv_show = build_stubbed(:tv_show, title: '')

    expect(tv_show.valid?).to eq(false)
  end
end
