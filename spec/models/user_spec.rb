require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:post1) { create(:post) }
  let(:post2) { create(:post) }
  let!(:like) { create(:like, user_id: user.id, post_id: post1.id) }

  describe '#liked_by?' do
    context 'ユーザがその投稿にいいねをしている場合' do
      it 'trueを返すこと' do
        expect(user.liked_by?(post1.id)).to be_truthy
      end
    end
    context 'ユーザがその投稿にいいねをしていない場合' do
      it 'falseを返すこと' do
        expect(user.liked_by?(post2.id)).to be_falsey
      end
    end
  end
end
