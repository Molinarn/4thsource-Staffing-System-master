class ExportExcelController < ApplicationController
  
  def index 
      
    @candidates = Candidate.find_by_sql(session["excelQry"]);    
    
    csv_string = CSV.generate do |csv|
         csv << ["Name", "First Last Name", "Second Last Name","E-mail", "Phone","Location", "Willing to relocate","Status", 
           "Visa", "Passport", "Rate (Salary expectation)", "English Score", "Result Tech Interview", 
           "Result Managerial Interview", "Current Salary", "Marital Status"]
         @candidates.each do |candi|
           
           @english =""
           @techSkill =""
           @managerial=""
           @status = ""
           @maritalStatus = ""
           
           # Status general de candidado
           if candi.currently_in_4Source == 1
             @status= "Hired"
           elsif candi.candidates_interviews.length == 0 
             @status = "Archived"
           else
             @status = "on hold"
           end
           
           # Descripcion del estado marital del candidato
           if candi.marital_status == 1
              @maritalStatus = "Single"
           elsif candi.marital_status == 2
              @maritalStatus = "Married"
           elsif candi.marital_status == 3
              @maritalStatus = "Divorced"
           elsif candi.marital_status == 4
              @maritalStatus = "Widowed"
           end 
           
           # Se obtienen los resultado de las entrevistas del candidato
           candi.candidates_interviews.each do |inter|
             
              if inter.interview_type_id == 2
                @english = inter.result
              end
              if inter.interview_type_id == 3
                @techSkill = inter.result
              end
              if inter.interview_type_id == 4
                @managerial = inter.result
              end
           end
           
           # Se genera la estructura del archivo CVS
           csv << [ candi.first_name,  candi.first_last_name, candi.second_last_name, 
             candi.email, candi.cell_phone,
             candi.city, candi.is_willing_to_relocate==true ? "yes":"no", @status,
             candi.has_visa==true ? "yes":"no", candi.has_passport==true ? "yes":"no", 
             candi.salary_expectancy,@english, @techSkill , @managerial, candi.current_salary, 
             @maritalStatus]
         end
    end         
  
   send_data csv_string,
   :type => 'text/csv; charset=iso-8859-1; header=present',
   :disposition => "attachment; filename=users.csv"
  end 
  
  
end