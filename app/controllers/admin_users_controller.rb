class AdminUsersController < ApplicationController
before_filter :isSuperAdmin

  def index

    puts "\nadmin_user#index".green

    set_my_wall(nil)
    set_wall_candidate(nil)
    @candidates = Candidate.joins(:admin_users)
  end

  def new

    puts "\nadmin_user#new".green

    #@admin_user = AdminUser.new
    @candidate = Candidate.find_by_id(params[:candidate_id])
    @admin_user = @canidate.AdminUser.new
    @admin_user =
    @error = admin_user.errors

    unless params[:letra].nil?
      @candidates = Candidate.joins("LEFT OUTER JOIN admin_users ON admin_users.candidate_id=candidates.id").where('first_last_name LIKE ?', params[:letra] + '%').order('first_last_name')
    else
      @candidates = Candidate.joins("LEFT OUTER JOIN admin_users ON admin_users.candidate_id=candidates.id").where('first_last_name LIKE "a%"').order('first_last_name')
    end

  end

  def add

    puts "\nadmin_user#add".blue

    unless params[:id].nil?
      @u = AdminUser.where(:candidates_id => params[:id].to_i)
      if @u.nil? or @u.length == 0
        @AdminUser = AdminUser.new
        @AdminUser.candidate_id = params[:id]
        @AdminUser.is_active = 1
        @AdminUser.lvl = 0
        @AdminUser.save
        #render text: "User added successfully"
        render text => "User added successfully"
      else
        #render text: "User already exists in admin catalog "
        render text => "User already exists in admin catalog "
      end
    else
      render text:"Incorrect parameters"
    end
  end

  def edit
    begin

      puts "\nadmin_user#edit".green

      @user = admin_users.where('candidate_id = ?', params[:id].to_i).first

      #@user = AdminUsers.where('candidates_id = ?', params[:id].to_i).first()
      if @user == nil
        #render text: "User not found " + params[:id]
        render text => "User not found " + params[:id]
      else
        case params[:role].to_i
        when 0 then
          @user.lvl = 0
          @user.is_active = 0
        when 1
          @user.lvl = 0
          @user.is_active = 1
        when 2
          @user.lvl = 1
          @user.is_active = 1
        end          
        if @user.save
          @candidates = Candidate.joins(:admin_users).order('first_last_name')
          render :update, :layout => false
        else
          #render text: @user.errors.full_messages
          render text => @user.errors.full_messages
        end
      end
    rescue Exception => e
      #render text: "User not found " + params[:id] + ", " + e.message + ", " + e.backtrace.inspect
      render text => "User not found " + params[:id] + ", " + e.message + ", " + e.backtrace.inspect
    end
  end

  def search    
    @candidates = Candidate.includes(:admin_users).where('first_name LIKE ? OR first_last_name LIKE ? OR email LIKE ?', params[:txt] + '%',params[:txt] + '%',params[:txt] + '%').order('first_last_name')
    render :newajax, :layout => false
  end

  def search    
    @candidates = Candidate.includes(:admin_users).where('first_name LIKE ? OR first_last_name LIKE ? OR email LIKE ?', params[:txt] + '%',params[:txt] + '%',params[:txt] + '%').order('first_last_name')
    render :newajax, :layout => false
  end

end
