class InterviewsQuestionsController < ApplicationController

  def new
    if request.post?
      @question = InterviewsQuestion.new
      @question.question = params[:interviews_question][:question]
      @question.interviews_type_id = params[:interview_type_id]
      if @question.save
        redirect_to File.join('/staff/', current_candidate.id.to_s, '/interviews_types', @question.interviews_type_id.to_s, '/edit' )
      end

    end

  end

end
