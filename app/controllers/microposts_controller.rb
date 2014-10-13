class MicropostsController < ApplicationController 
  before_filter :authenticate,    :only => [:create, :reply, :update, :feed_micropost, :destroy]
  before_filter :authorized_candidate, :only => :destroy

  def create
    content = params[:message_text]
    candidate_id = params[:candidate_id]
    created_by = current_candidate.id
    @candidate = Candidate.find(candidate_id)
    @micropost = @candidate.microposts.new(:content => content, :candidate_id => candidate_id, :created_by => created_by, :is_active => 1, :checked => 0)
    @error = @micropost.errors
    if @micropost.save
      flash[:success] = "Micropost created!"
      @micropost.update_attributes(:chain_id => @micropost.id)
      MicropostsMailer.micropost(@micropost, @candidate, current_candidate).deliver
      redirect_to root_path
    else
      flash[:notice] = "Message required, and no more than 140 charactes."
      redirect_to "/candidates/#{candidate_id}/resume"
    end
  end

  def reply
    micropost_reply = Micropost.find(params[:reply_id]);
    original_micropost = Micropost.find(micropost_reply.chain_id);
    content = params[:reply_text]        

    _created_by = current_candidate.id.to_i
    _candidate_id = micropost_reply.created_by.to_i

    _micropost = nil

    if _created_by == _candidate_id
      _candidate_id = micropost_reply.candidate_id.to_i      
    end

    _micropost = Candidate.find(_candidate_id)
    micropost = _micropost.microposts.build(:content => content, :candidate_id => _micropost.id, :created_by => _created_by, :is_active => 1, :checked => 0, :chain_id => micropost_reply.chain_id)
    error = micropost.errors
    if micropost.save      
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(:is_active => '0')
      flash[:success] = "Micropost removed"
      redirect_back_or root_path
    end
  end

  def feed_micropost
    @page_results = nil
    @convo_chain_id = nil
    @user_wall = false

    if params[:wall] == '1'
      @user_wall = true
    end

    if params[:id] != "0"
      if params[:solomicro] == "0"
        #format.json { render :json =>  @page_results = Micropost.find(:all, :select =>"microposts.id, microposts.content, microposts.candidate_id, microposts.created_at, microposts.updated_at, microposts.created_by, microposts.checked, microposts.is_active, candidates.id, candidates.first_name, candidates.first_last_name", :joins => "JOIN candidates ON candidates.id = microposts.created_by", :conditions => ["microposts.is_active = 1 AND (microposts.candidate_id = ? OR microposts.created_by = ?)", params[:id], params[:id]])}
        #@page_results = Micropost.find(:all, :select =>"microposts.id microid, microposts.content, microposts.candidate_id, microposts.created_at, microposts.updated_at, microposts.created_by, microposts.checked, microposts.is_active, candidates.id candidateid, candidates.first_name, candidates.first_last_name", :joins => "JOIN candidates ON candidates.id = microposts.created_by", :conditions => ["microposts.is_active = 1 AND (microposts.candidate_id = ? OR microposts.created_by = ?)", params[:id], params[:id]])
        @page_results = Micropost.find(:all, :order => "microposts.created_at DESC", :select =>"microposts.id microid", :joins => "JOIN candidates ON candidates.id = microposts.created_by", :conditions => ["microposts.is_active = 1 AND (microposts.candidate_id = ? OR microposts.created_by = ?)", params[:id], params[:id]])
      elsif params[:solomicro] == "1"
        #format.json { render :json =>  @page_results = Micropost.find(:all, :select =>"microposts.id, microposts.content, microposts.candidate_id, microposts.created_at, microposts.updated_at, microposts.created_by, microposts.checked, microposts.is_active, candidates.id, candidates.first_name, candidates.first_last_name", :joins => "JOIN candidates ON candidates.id = microposts.created_by", :conditions => ["microposts.created_by != microposts.candidate_id AND microposts.candidate_id NOT IN (SELECT microposts.candidate_id FROM microposts WHERE microposts.candidate_id NOT IN(:follower_id, :user_being_followed)) AND microposts.created_by NOT IN (SELECT microposts.created_by FROM microposts WHERE microposts.created_by NOT IN(:follower_id, :user_being_followed)) AND microposts.is_active = 1",{:follower_id => id_current_candidate.to_i, :user_being_followed => params[:user_followed].to_i}])}
        @page_results = Micropost.find(:all, :order => "microposts.created_at DESC",:select =>"microposts.id microid", :joins => "JOIN candidates ON candidates.id = microposts.created_by", :conditions => ["microposts.created_by != microposts.candidate_id AND microposts.candidate_id NOT IN (SELECT microposts.candidate_id FROM microposts WHERE microposts.candidate_id NOT IN(:follower_id, :user_being_followed)) AND microposts.created_by NOT IN (SELECT microposts.created_by FROM microposts WHERE microposts.created_by NOT IN(:follower_id, :user_being_followed)) AND microposts.is_active = 1",{:follower_id => current_candidate.id.to_i, :user_being_followed => params[:user_followed].to_i}])      
      elsif params[:solomicro] == "2" && params[:conv_id]
        @convo_chain_id = params[:conv_id]
        @page_results = Micropost.find(:all, :order => "microposts.id ASC", :select =>"microposts.id microid", :conditions => ["(microposts.id IN ((SELECT microposts.chain_id FROM microposts WHERE microposts.id = :conversation_id)) OR microposts.chain_id IN ((SELECT microposts.chain_id FROM microposts WHERE microposts.id = :conversation_id))) AND microposts.is_active = 1",{:conversation_id => @convo_chain_id}])
      end
    else      
      if params[:conv_id] != "0"
        @convo_chain_id = params[:conv_id]
        @page_results = Micropost.find(:all, :order => "microposts.id ASC", :select =>"microposts.id microid", :conditions => ["(microposts.id IN ((SELECT microposts.chain_id FROM microposts WHERE microposts.id = :conversation_id)) OR microposts.chain_id IN ((SELECT microposts.chain_id FROM microposts WHERE microposts.id = :conversation_id))) AND microposts.is_active = 1",{:conversation_id => @convo_chain_id}])
      else
        @page_results = Micropost.find(:all, :order => "microposts.created_at DESC", :select =>"microposts.id microid", :joins => "JOIN candidates ON candidates.id = microposts.created_by", :conditions => ["microposts.is_active = 1 AND (microposts.candidate_id = ? OR microposts.created_by = ?)", current_candidate.id.to_i, current_candidate.id.to_i])
      end
    end
        
    render partial: 'shared/micropost_feed'
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end 

  private
  def authorized_candidate
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless current_user?(@micropost.user)
  end
end