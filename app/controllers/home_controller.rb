class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
      if params[:commit] == "検索" #フリーワード検索ボタン押した時
        freeword_divise_search
      elsif params[:commit] == "詳細検索" #詳細検索ボタン押した時
        @q = Post.ransack(params[:q])
      elsif params[:q].blank? #何もない時
        params[:q] = { sorts: 'created_at desc'}
        @q = Post.ransack(params[:q])
      else #ソートボタン押した時
        if params[:q][:name_or_address_or_caption_or_user_name_cont_any].present? #フリーワードあったら
          freeword_divise_search
        else #なかったら
          @q = Post.ransack(params[:q])
        end
      end
      @results = @q.result(distinct: true).page(params[:page]).includes([images_attachments: :blob], [user: [icon_attachment: :blob]], :likes).per(25)
      @count = @q.result.count
      @randoms = Post.includes([images_attachments: :blob], :user).where.not(images_attachments: {id: nil}).order("RAND()").limit(5)
      @randoms_count = @randoms.count
  end

  private

  def freeword_divise_search
    key_words = params[:q][:name_or_address_or_caption_or_user_name_cont_any].split(/[\p{blank}\s]+/)
    grouping_hash = key_words.reduce({}){|hash, word| hash.merge(word  => { name_or_address_or_caption_or_user_name_cont_any: word })}
    @q = Post.ransack({ combinator: 'and', groupings: grouping_hash, sorts: params[:q][:sorts] })
  end
end
