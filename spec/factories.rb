FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "a#{n}@b.cd" }
    password 'password'
    authentication_token 'token'

    factory :admin, class: User do
      admin true
    end
  end

  factory :tv_show do
    title 'House M.D.'
    description 'drama'
    rank 10

    factory :tv_show_with_two_episodes do
      after(:create) do |tv_show|
        create_list(:episode, 2, tv_show: tv_show)
      end
    end
  end

  factory :episode do
    title 'One Day, One Room'
    sequence(:episode) { |n| 58 + n }
    tv_show
  end

  factory :user_tv_show do
    user
    tv_show

    factory :user_tv_show_with_first_of_two_episodes_watched do
      association :tv_show, factory: :tv_show_with_two_episodes

      after(:create) do |user_tv_show|
        user_id = user_tv_show.user_id
        tv_show = user_tv_show.tv_show

        create(
          :user_episode,
          user_id: user_id,
          episode: tv_show.episodes.first,
          watched: true
        )
      end
    end
  end

  factory :user_episode do
    user
    episode

    after(:create) do |user_episode|
      user = user_episode.user
      episode = user_episode.episode

      if !user.tv_shows.where(id: episode.tv_show.id).exists?
        user.tv_shows << episode.tv_show
      end
    end
  end
end
