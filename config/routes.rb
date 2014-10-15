StaffingApp::Application.routes.draw do  

  root :to => 'sessions#new'

  resources :candidates_profiles

  get "email/remind"

  post "email/remind"

  resources :admin_users do
  end

  resources :candidates do
    member do
      get :following, :followers, :change, :index
      post :change
    end
    collection do
      get 'search'
    end

  end

  resources :pages do
    collection do
      get 'search'
    end
  end
  
  resources :ExportExcel  
  
  resources :candidates do
    resources :candidate_certifications
    resources :candidates_profiles
    resources :candidate_profile_tags
  end

  resources :sessions,   :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :reply, :update, :feed_micropost, :destroy]
  
  resources :followings do
    collection do 
       post  'follow'
    end
  end

  resources :resume
  resources :candidate_prof_summaries do
    collection do
      get 'destroy'
      post 'destroy'
    end
  end

  resources :candidate_certifications do
    collection do
      get 'destroy'
      post 'destroy'
    end
  end  

  resources :jobs

  match "staff/:id/job_match"=>'job_match#index'
  match "staff/:id/job_match/index"=>'job_match#index'
  #match "/job_match"=>'job_match#match'
  match "/job_match/search/:jobSearch"=>'job_match#search'
  match "/job_match/match/:jobSearch/:matchPercentage"=>'job_match#match'
  match "/job_match/match" =>'job_match#match'
  #match "/job_match/autocomplete" => 'job_match#autocomplete'
  #match "candidates/:id/job_match/information" => 'job_match#information'
  #match "/job_match/match/:jobSearch/:matchPercentage"=>'job_match#match'
  #match "/job_match/match/:matchPercentage" =>'job_match#match'

  match "/staff/:id/certifications/action" => 'certifications#action'

  match "staff/:id/jobs"=>'jobs#index'  
  match "staff/:id/jobs/index"=>'jobs#index'
  match "staff/:id/jobs/new"=>'jobs#new'
  match "staff/:id/jobs/edit"=>'jobs#edit'
  match "staff/:id/jobs/create"=>'jobs#create'
  match "staff/:id/jobs/:job_id/edit"=>'jobs#edit'
  match "staff/:id/jobs/:job_id/update"=>'jobs#update'
  match "staff/:id/jobs/:job_id/delete"=>'jobs#destroy'
  match "staff/:id/jobs/:job_id/assign/:candidate_id"=>'jobs#assign'
  match "staff/:id/jobs/:job_id/duplicate"=>'jobs#duplicate'



  match "admin_users/:id/edit/:role" => 'admin_users#edit'
  match "admin_users/new/:letra" => 'admin_users#new'
  match "admin_users/:id/add" => 'admin_users#add'
  match "admin_users/search/:txt" => 'admin_users#search'

  match "interviewer_user/:interviewer_id/new/:letra" => 'interviewer_user#new'
  match "interviewer_user/:interviewer_id/new" => 'interviewer_user#new'
  match "interviewer_user/:interviewer_id/add/:candidate_id" => 'interviewer_user#add'

  match '/signup',  :to => 'candidates#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/home',    :to => 'pages#home'

  #microposts
  match "/candidates/:id/followings" => 'followings#follow'
  match "/candidates/:id/unfollow" => 'followings#destroy'
  match "/candidates/:id/profiles" => 'candidates#profiles'
  #match "/candidates/:id/microposts" => 'microposts#create'

  match "/reply/:id" => 'microposts#reply'
  match "/reply" => 'microposts#reply'
  match "/microposts/:id" => 'microposts#update'
  match "/feed_admin/:id" => 'microposts#feed_micropost'
  match "/candidates/:id/wall" => 'user_walls#show' 

  #Resume
  match "/candidates/:id/resume" => 'resume#index'
  match "/candidates/:id/resume/staff_update" => 'resume#staff_update'
  match "/candidates/:id/resume/summary" => 'resume#summary'
  match "/candidates/:id/resume/experience" => 'resume#experience'
  match "/candidates/:id/resume/experience/new" => 'experiences#new'
  match "/candidates/:id/resume/experience/:experience_id/skills/new" => 'experiences#skill'
  match "/experiences/:id/destroy" => 'experiences#destroy'
  match "/candidates/:id/resume/experience/:experience_id/details/new" => 'experience_details#new'
  #match "/resume_details/:id/destro" => 'resume_details#destro'
  match "/candidate_prof_summaries/destro" => 'candidate_prof_summaries#destro'
  #match "/resume_details/:id/destroy" => resume_details_destroy_path
#  match "/candidates/:id/resume/education" => 'resume#education'
#  match "/education/destroy" => 'educations#destroy'

  # Projects
  match "/candidates/:id/projects" => 'projects#index'
  match "/candidates/:id/projects/profile" => 'projects#profile'
  match "/candidates/:id/projects/projects/profile" => 'projects#profile'
  match "/candidates/:id/projects/buildprofile" => 'projects#buildprofile'
  match "/candidates/:id/projects/projects/buildprofile" => 'projects#buildprofile'
  match "/candidates/:id/projects/techs" => 'projects#techs'
  match "/candidates/:id/projects/techs/save" => 'projects#techs_save'
  match "/candidates/:id/project/:project_id/projects/techs" => 'projects#techs'
  match "/candidates/:id/project/:project_id/projects/techs/save" => 'projects#techs_save'
  match "/candidates/:id/projects/new" => 'projects#new'
  match "/candidates/:id/project/:project_id/update" => 'projects#update'
  match "/candidates/:id/project/:project_id/show" => 'projects#show'
  match "/candidates/:id/project/:project_id/destroy" => 'projects#destroy'

  ## Project Roles
  match "/candidates/:id/project/:project_id/projects_roles/new" => 'projects_roles#new'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/update" => 'projects_roles#update'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/show" => 'projects_roles#show'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/destroy" => 'projects_roles#destroy'
 
  ## Project Responsibilities
  match "/candidates/:id/projects/:project_id/projects_roles/:projects_role_id/roles_responsibilities/new" => 'roles_responsibilities#new'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/roles_responsibilities/:rolerespon_id/destroy" => 'roles_responsibilities#destroy'

  ## Project Tags
  match "/candidates/:id/projects/:project_id/projects_roles/:projects_role_id/projects_tags/:type_id/new" => 'projects_tags#new'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/projects_tags/:projtag_id/destroy" => 'projects_tags#destroy'
  
  # Education
  match "/education/:id" => 'education#index', :as => :candidate_education
  match "/education/destroy" => 'candidate_education#destroy'
  match "/candidates/:id/resume/education" => 'candidate_education#index'
  match "/candidates/:id/resume/education/new" => 'candidate_education#new'
  match "/candidates/:id/resume/education/create" => 'candidate_education#create', :as => :candidate_education_index
  match "/candidates/:id/resume/education/edit" => 'candidate_education#edit'
  match "/candidates/:id/resume/education/update" => 'candidate_education#update'
  match "/candidates/:id/resume/education/destroy" => 'candidate_education#destroy'
  match "/candidates/:id/education_degree" => 'educ_degree#index'
  match "/candidates/:id/education_degree/new" => 'educ_degree#new'
  match "/candidates/:id/education_degree/create" => 'educ_degree#create'
  match "/candidates/:id/education_degree/edit" => 'educ_degree#edit'
  match "/candidates/:id/education_degree/update" => 'educ_degree#update'
  match "/candidates/:id/education_degree/destroy" => 'educ_degree#destroy'
  match "/candidates/:id/education_degree/action" => 'educ_degree#action'

  match "/candidates/:id/candidate_certifications/new" => 'candidate_certifications#new'

  # Candidate
  match "/staff/:id/candidates" => 'staff_candidates#index'
  match "/staff/:id/candidates/detail" => 'staff_candidates#search'

  # Candidate Status
  match "/staff/:id/candidate_status" => 'status#index'
  match "/staff/:id/candidate_status/create" => 'status#create'
  match "/staff/:id/candidate_status/destroy" => 'status#destroy'

  # Interviewers
  match "/staff/:id/interviewers" => 'interviewers#index'
  match "/staff/:id/interviewers/new" => 'interviewers#new'
  match "/staff/:id/interviewers/:interviewer_id/edit" => 'interviewers#edit', :as => :interviewer
  match "/staff/:id/interviewers/:interviewer_id/delete" => 'interviewers#delete'

  # Candidate Certification
  match "/candidates/:id/certification" => 'candidate_certification#index'
  #match "/candidates/:id/resume/certification/new" => 'candidate_certification#new'
  match "/candidate_certifications/destro" => 'candidate_certifications#destro'
  #match "/resume_details/destro" => 'resume_details#destro'
  
  # Certifications
  match "/staff/:id/certifications" => 'certifications#index'
  match "/staff/:id/certifications/action" => 'certifications#action'
  match "/staff/:id/certifications/new" => 'certifications#new'
  match "/staff/:id/certifications/:certification_id/edit" => 'certifications#edit'
  match "/staff/:id/certifications/:certification_id/delete" => 'certifications#delete'
  
  # Roles
  #match "/candidates/:id/project/project_id/projects_role/projects_role_id/roles" => 'roles#index'
  match "/staff/:id/roles" => 'roles#index'
  match "/staff/:id/roles/action" => 'roles#action'
  match "/staff/:id/roles/new" => 'roles#new'
  match "/staff/:id/roles/:role_id/edit" => 'roles#edit'
  match "/staff/:id/roles/:role_id/delete" => 'roles#delete'
  
  # Trainings
  match "/candidates/:id/resume/training" => 'candidate_training#index'
  match "/candidates/resume/training/new" => 'candidate_training#new'
  match "/training/destroy" => 'candidate_training#destroy'

  # Languages
  match "/candidates/:id/resume/languages" => 'candidate_languages#index'
  match "/candidates/resume/languages/new" => 'candidate_languages#new'
  match "/candidates/:id/resume/:candidate_language/languages/edit" => 'candidate_languages#edit'  
  match "/languages/destroy" => 'candidate_languages#destroy'
  match "/staff/:id/languages" => 'languages#index'
  match "/staff/:id/languages/new" => 'languages#new'
  match "/staff/:id/languages/create" => 'languages#create'
  match "/staff/:id/languages/action" => 'languages#action'

  # Tags
  match "/staff/:id/tags" => 'tags#index'
  match "/staff/:id/tags/new" => 'tags#new'
  match "/staff/:id/tags/create" => 'tags#create'
  match "/staff/:id/tags/edit" => 'tags#edit'
  match "/staff/:id/tags/update" => 'tags#update'
  match "/staff/:id/tags/destroy" => 'tags#destroy'
  match "/staff/:id/tags/action" => 'tags#action'
  match "/staff/:id/tags/knowledges" => 'tags#knowledges'
  match "/staff/:id/tags/knowledges/process" => 'tags#knowledges_process'
  match "/staff/:id/tags/knowledges/delete" => 'tags#knowledges_delete'
  match "/staff/:id/tags/tools" => 'tags#tools'
  match "/staff/:id/tags/tools/process" => 'tags#tools_process'
  match "/staff/:id/tags/tools/delete" => 'tags#tools_delete'
  match "/staff/:id/tags/languages" => 'tags#languages'
  match "/staff/:id/tags/languages/process" => 'tags#languages_process'
  match "/staff/:id/tags/languages/delete" => 'tags#languages_delete'  
  match "/staff/:id/tags/languages/:tech/tech" => 'tags#technologies'
  match "/staff/:id/tags/languages/:tech/tech/process" => 'tags#technologies_process'
  match "/staff/:id/tags/languages/:tech/tech/delete" => 'tags#technologies_delete'
#  match "/staff/:id/tags/platform" => 'tags#platform'

  # Report
  match "/staff/:id/report" => 'report#index'
  match "/staff/:id/report/search" => 'report#search'
  match "/staff/:id/interviews/report" => 'candidates_interviews#report'
  match "/staff/report" => 'report#reportform'
  match "/staff/report/buildlist" => 'report#buildlist'
  #match "/staff/:id/report/search" => 'report#search'
 
  # Autocomplete
  match "/tool/autocomplete" => 'tool_tag#autocomplete'
  match "/tech/autocomplete" => 'technology_tag#autocomplete'
  match "/know/autocomplete" => 'knowledge_tag#autocomplete'

  match '/skills', :to => 'skills#index'
  match '/skills/new', :to => 'skills#new' 
  
  # Candidates Interviews
  match "/candidates/:id/candidates_interviews" => 'candidates_interviews#index'
  match "/candidates/:id/candidates_interviews/new" => 'candidates_interviews#new'
  match "/candidates/:id/candidates_interviews/:cand_inter_id/edit" => 'candidates_interviews#edit'
  match "/candidates/:id/candidates_interviews/:cand_inter_id/doit" => 'candidates_interviews#doit' , :as => :candidates_interview
  match "/candidates/:id/candidates_interviews/:cand_inter_id/view" => 'candidates_interviews#view'
  match "/candidates/:id/candidates_interviews/:cand_inter_id/delete" => 'candidates_interviews#delete'
  match "/candidates/candidates_interviews/editest" => 'candidates_interviews#status_process'

  ## Interviews Type
  match "/staff/:id/interviews_types" => 'interviews_types#index'
  match "/staff/:id/interviews_types/new" => 'interviews_types#new'
  match "/interviews_types/search/:interview_type_id" => 'interviews_types#search'
  match "/staff/:id/interviews_types/:interview_type_id/edit" => 'interviews_types#edit', :as => :interviews_type
  match "/staff/:id/interviews_types/:interview_type_id/delete" => 'interviews_types#delete'
 
  # Interviews Question
  match "/staff/:id/interviews_questions/:interview_type_id/add" => 'interviews_questions#new'  

  ## Candidates Profiles

  ##Added
  match "/candidates/:id/candidate_profiles" => 'candidates_profiles#index'

  match "/candidates_profiles" => 'candidates_profiles#index'
  match "/candidates_profiles/:candidates_profile_id/editprofile" => 'candidates_profiles#editprofile'
  match "/candidates_profiles/new" => 'candidates_profiles#new'
  match "/candidates_profiles/save" => 'candidates_profiles#save'
  match "/candidates_profiles/:candidates_profile_id/update" => 'candidates_profiles#update'
  match "/candidates_profiles/:candidates_profile_id/show" => 'candidates_profiles#show'
  match "/candidates_profiles/:candidates_profile_id/delete" => 'candidates_profiles#delete'
  match "/candidates_profiles/:candidates_profile_id/createjob" => 'candidates_profiles#createjob'
  #match "/candidates/:candidate_id/candidate_profiles/:candidate_profile_id/update" => 'candidate_profiles#update'
  #match "/candidates/:candidate_id/candidate_profiles/:candidate_profile_id" => 'candidate_profiles#update'
  #match "/candidates/candidate_profiles/:id/update_tags" => 'candidate_profiles#update_tags'
  #match "/candidates/:candidate_id/admin" => 'candidate_profiles#admin'
  match "/candidates/:candidate_id/admin" => 'candidates_profiles#admin'

  ## New Candidate by admin
  match "/staff/newcandidate" => 'candidates#newcandidate'

  ## Docx Generator
  match "/candidates/:candidate_id/docx" =>'candidates_profiles#docx'

#  root :to => 'pages#home'
end
