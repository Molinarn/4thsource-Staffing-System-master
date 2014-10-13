class CandidatesInterviewFilter
  TYPE = [['Identified', 'Identified'], ['Applicant', 'Applicant']]
  RELOCATION = [['Yes', '1'], ['No', '0']]
  
  @startDate = nil
  @endDate = nil
  @minResult = nil
  @maxResult = nil
  @interviews_type_id = nil
  @is_willing_to_relocate = nil
  @referral_typep = nil

  def initialize(params)
    if !params["startDate"].blank? and !params["endDate"].blank?
      @startDate = DateTime.strptime(params["startDate"], '%m/%d/%Y') 
      @endDate = DateTime.strptime(params["endDate"], '%m/%d/%Y').end_of_day()
    end

    if !params["minResult"].blank? and !params["maxResult"].blank?
      @minResult = "%.2f" % params["minResult"].to_f
      @maxResult = "%.2f" %params["maxResult"].to_f
    end

    if !params["interviews_type_id"].blank?
      @interviews_type_id = params["interviews_type_id"]
    end
   
    if !params["is_willing_to_relocate"].blank?
      @is_willing_to_relocate = params["is_willing_to_relocate"]
    end
 
    if !params["referral_type"].blank?
     @referral_type = params["referral_type"]
    end
  end 

  def by_DateRange?
    !(@startDate.nil? and @endDate.nil?)
  end

  def dateRange
    @startDate..@endDate
  end

  def by_ResultRange?
    !(@minResult.nil? and @maxResult.nil?)
  end

  def resultRange
    @minResult..@maxResult
  end

  def by_InterviewsType?
    !@interviews_type_id.nil?
  end

  def interviews_type_id
    @interviews_type_id
  end

  def by_WillingRelocate?
    !@is_willing_to_relocate.nil?
  end
  
  def is_willing_to_relocate
    @is_willing_to_relocate
  end

  def by_ReferralType?
    !@referral_type.nil?
  end

  def referral_type
    @referral_type
  end

end
