class PagesController < ApplicationController

  def home
    @title = "Home"
    @micropost = Micropost.new if signed_in?
    @error = current_candidate.errors if signed_in?
    @page_results = []
    @page_results = current_candidate.feed.paginate(:page => params[:page]) if signed_in? and current_candidate.feed != nil
    if ['Admin', 'Super Admin'].include?( get_user_type )
      @followers_list = []
      @page_results2 = []
      @followers_list = current_candidate.followers
      @followers_list.each do | i |
        tmp_candidate = Candidate.find(i.followed_id)
        @page_results2 << (tmp_candidate)
      end
    end
    @candidate = current_candidate
    set_wall_candidate(nil)
    set_my_wall(nil)
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def search
    if params[:q]
      query = params[:q]
      @title = "Home"
      @candidate = current_candidate
      @micropost = Micropost.new if signed_in?
      @error = current_candidate.errors if signed_in?
      @feed_items = Micropost.search_from_candidates_followed_by(current_candidate, query)
      paginate(@feed_items, 5)
      flash.now[:success] = "About #{@feed_items.count} results."
      render 'home'
    end
  end
end
