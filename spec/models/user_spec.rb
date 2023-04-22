require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let(:not_followed_user) { create(:user) }
  let(:liked_post) { create(:post) }
  let(:not_liked_post) { create(:post) }
  let!(:like) { create(:like, user_id: user.id, post_id: liked_post.id) }
  let!(:relationship) { create(:relationship, following_id: user.id, follower_id: followed_user.id) }

  describe '#liked_by?' do
    context 'ユーザがその投稿にいいねをしている場合' do
      it 'trueを返すこと' do
        expect(user.liked_by?(liked_post.id)).to be_truthy
      end
    end
    context 'ユーザがその投稿にいいねをしていない場合' do
      it 'falseを返すこと' do
        expect(user.liked_by?(not_liked_post.id)).to be_falsey
      end
    end
  end

  describe '#followed_by?' do
    context 'そのユーザーをログインユーザーがフォローしている場合' do
      it 'trueを返すこと' do
        expect(followed_user.followed_by?(user.id)).to be_truthy
      end
    end

    context 'そのユーザーをログインユーザーがフォローしていない場合' do
      it 'falseを返すこと' do
        expect(not_followed_user.followed_by?(user.id)).to be_falsey
      end
    end
  end
end
