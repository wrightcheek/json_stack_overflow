require 'so'

RSpec.describe SO::Post do
  let :post_hash do
    {:owner=>
      {:reputation=>10695,
       :user_id=>184212,
       :user_type=>"registered",
       :accept_rate=>67,
       :profile_image=>
        "https://www.gravatar.com/avatar/b31e7abd14f1ceb4c4957da08933c630?s=128&d=identicon&r=PG",
       :display_name=>"Joshua Cheek",
       :link=>"http://stackoverflow.com/users/184212/joshua-cheek"},
     :score=>41,
     :last_edit_date=>1334502937,
     :last_activity_date=>1429590279,
     :creation_date=>1275217048,
     :post_type=>"question",
     :post_id=>2938301,
     :link=>"http://stackoverflow.com/q/2938301"}
  end

  let(:post) { SO::Post.new post_hash }

  it 'knows the score, last_edit_date, last_activity_date, creation_date, post_type, post_id, and link' do
    expect(post.score              ).to eq 41
    expect(post.last_edit_date     ).to eq 1334502937 # ??
    expect(post.last_activity_date ).to eq 1429590279 # ??
    expect(post.creation_date      ).to eq 1275217048 # ??
    expect(post.post_type          ).to eq "question"
    expect(post.post_id            ).to eq 2938301
    expect(post.link               ).to eq "http://stackoverflow.com/q/2938301"
  end

  it 'knows the owner\'s information' do
    owner = post.owner
    expect(owner.reputation    ).to eq 10695
    expect(owner.user_id       ).to eq 184212
    expect(owner.user_type     ).to eq "registered"
    expect(owner.accept_rate   ).to eq 67
    expect(owner.profile_image ).to eq "https://www.gravatar.com/avatar/b31e7abd14f1ceb4c4957da08933c630?s=128&d=identicon&r=PG"
    expect(owner.display_name  ).to eq "Joshua Cheek"
    expect(owner.link          ).to eq "http://stackoverflow.com/users/184212/joshua-cheek"
  end
end
