require 'logger'
require 'Zipper'
require 'customqueries'

class ProfileBuilder2
  
  attr_accessor :cid, :filter, :summaryprof, :nameprof, :candidate_id

  def language_level_list
      [
        ['- Select one -', ''],
        ['Advanced',1],
        ['Upper intermediate',2],
        ['Intermediate',3],
        ['PreIntermediate',4],
        ['Elementary',5],
        ['PreElementary',6]

      ]
  end

  def IsValueInFilter(hasfilter, type, value, filter)
    @include = false
    if hasfilter
      if filter.include? "{##{type}:#{value}#}"
        @include = true
      end
    else
      @include = true
    end 
    @include   
  end

  def getTagAndTechs(values)
      @tmptools = ""
      values.each { |k, v|
        @tmptools = @tmptools + ", " unless  @tmptools == ""
        @tmptools = @tmptools + k
        @tmptech = ""
        v.each { |k2, v2 |
          @tmptech = @tmptech + ", " unless @tmptech == ""
          @tmptech = @tmptech + k2
        }
        @tmptools = @tmptools + " (#{@tmptech})" unless @tmptech == ""
      }    
      @tmptools
  end

  def build

    puts "\nProfileBuilder2#build".green

    @hasfilter = false
    @hasfilter = true unless @filter == "";
    @tmpleducation = '<w:p><w:pPr><w:pStyle w:val="No Spacing"/><w:ind w:hanging="360"/><w:ind w:left="720"/><w:numPr><w:ilvl w:val="0"/><w:numId w:val="130"/></w:numPr></w:pPr><w:r><w:rPr></w:rPr><w:t xml:space="preserve">  </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">#TITLE# - </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve"> #DESC#</w:t></w:r></w:p>'
    @worktask = '<w:p><w:pPr><w:pStyle w:val="No Spacing"/><w:ind w:hanging="360"/><w:ind w:left="720"/><w:numPr><w:ilvl w:val="0"/><w:numId w:val="140"/></w:numPr></w:pPr><w:r><w:rPr></w:rPr><w:t xml:space="preserve">  </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">#WORK_PROJECT_TASK#.</w:t></w:r></w:p>'
    @workdata = '<w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">Project: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">#WORK_PROJECTNAME#</w:t></w:r></w:p><w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr></w:p><w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">#WORK_PROJECTDESC#</w:t></w:r></w:p><w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr></w:p><w:tbl><w:tblGrid><w:gridCol w:w="5400"/><w:gridCol w:w="5400"/></w:tblGrid><w:tblPr><w:tblBorders><w:left w:val="single"/><w:right w:val="single"/><w:top w:val="single"/><w:bottom w:val="single"/></w:tblBorders></w:tblPr><w:tr><w:trPr></w:trPr><w:tc><w:tcPr><w:tcW w:w="5400" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:color="ffffff"/><w:right w:val="single" w:color="ffffff"/><w:top w:val="single" w:color="ffffff"/><w:bottom w:val="single" w:color="ffffff"/></w:tcBorders></w:tcPr><w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">#WORK_ROLE#</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="5400" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:color="ffffff"/><w:right w:val="single" w:color="ffffff"/><w:top w:val="single" w:color="ffffff"/><w:bottom w:val="single" w:color="ffffff"/></w:tcBorders></w:tcPr><w:p><w:pPr><w:pStyle w:val="No Spacing"/><w:jc w:val="right"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">#WORK_INITD#  -  #WORK_ENDD#</w:t></w:r></w:p></w:tc></w:tr></w:tbl><w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">   </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve"></w:t></w:r></w:p>#TASKS#<w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr></w:p><w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:b/><w:i/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">Technologies:</w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">  #WORK_TECH#</w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:i/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">.</w:t></w:r></w:p><w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr></w:p><w:p><w:pPr><w:pStyle w:val="No Spacing"/></w:pPr></w:p>'
    @certdata = '<w:r><w:rPr><w:rFonts w:ascii="Arial" w:cs="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">#CERT_TITLE#</w:t></w:r>'
    @candidate = Candidate.find_by_id(@candidate_id)
    @from = Rails.root.to_s << "/public/cvtemplate"
    @to = Rails.root.to_s + '/public/compressed.docx'
    File.open(Rails.root.to_s + "/public/template.xml", 'r') do |f|
      @template = f.read
    end
    @tools = Hash.new
    @knowledge = Hash.new
    @platform = Hash.new
    File.open(@from + "/word/document.xml", 'w') do |f|
      
      @template = @template.gsub('#NAME#', @candidate.first_name + " " + @candidate.first_last_name)
      @template = @template.gsub('#SUMMARY#', @summaryprof)
      @template = @template.gsub('#POSITION#', @nameprof)
      
      @title = ""
      @desc = ""
      @education = ""

      puts "\n@candidate.candidate_education.nil?: #{@candidate.candidate_education.nil?}".red

      @candidate.candidate_education.each do |education|

          puts "#{education.id}".magenta

          @title = education.educ_degree.name + " in " + education.title + ","
          @desc = education.university
          if education.date_in != nil && education.date_out != nil
              @desc = @desc + "  [" + Date::MONTHNAMES[education.date_in.month] + " " + education.date_in.year.to_s + " - " + Date::MONTHNAMES[education.date_out.month] + " " + education.date_out.year.to_s + "]"
          end
          @title = @tmpleducation.gsub('#TITLE#', @title)
          @title = @title.gsub('#DESC#', @desc)
          @education = @education + @title
      end
      @template = @template.gsub('#EDUCATION#', @education)
      
      @language = ""
      @candidate.candidate_languages.each do |candidate_language|
        @title = candidate_language.language.name unless candidate_language.language.nil?
        @desc = language_level_list[candidate_language.level_id][0]
        @title = @tmpleducation.gsub('#TITLE#', @title)
        @title = @title.gsub('#DESC#', @desc)
        @language = @language + @title
      end
      @template = @template.gsub('#LANG#', @language)

      @projects = ""
      @tmpproject = ""
      @include = false      
      @candidate.projects.each do |projects|
        @include = IsValueInFilter(@hasfilter, 'project', projects.id, @filter)
        if @include
          @tmpproject = @workdata
          @tmpproject = @tmpproject.gsub('#WORK_PROJECTNAME#', projects.name) if projects.name != nil
          @tmpproject = @tmpproject.gsub('#WORK_PROJECTDESC#', projects.summary) if projects.summary != nil
          projects.projects_roles.each do |roles|
            @include = IsValueInFilter(@hasfilter, 'role', "#{projects.id}/#{roles.roles.id}", @filter)
            if @include
              @tmpproject = @tmpproject.gsub('#WORK_ROLE#', roles.roles.name)
              @tmpproject = @tmpproject.gsub('#WORK_INITD#', Date::MONTHNAMES[roles.date_in.month] + roles.date_in.year.to_s)
              @tmpproject = @tmpproject.gsub('#WORK_ENDD#', Date::MONTHNAMES[roles.date_out.month] + roles.date_out.year.to_s)            
              @tasks = ""
              roles.roles_responsibilities.each do |role_responsibility|
                 @tasktmp = @worktask
                 @tasktmp = @tasktmp.gsub('#WORK_PROJECT_TASK#', role_responsibility.description)
                 @tasks = @tasks + @tasktmp
              end
              @tmpproject = @tmpproject.gsub('#TASKS#', @tasks)
              @techs = ""
              @project_techs = CustomQueries.getProjectTags(roles.id)
              @project_techs.each do |ptech|
                @include = IsValueInFilter(@hasfilter, 'tag', "#{projects.id}/#{roles.roles.id}/#{ptech[0]}", @filter)
                if @include
                  @techs = @techs + ", " if @techs != ""
                  @techs = @techs + ptech[2]     
                  case ptech[1]
                    when 1 then
                      @tools[ptech[2]] = Hash.new unless @tools.has_key?(ptech[2])
                    when 2 then
                      @knowledge[ptech[2]] = Hash.new unless @knowledge.has_key?(ptech[2])
                    when 3 then
                      @platform[ptech[2]] = Hash.new unless @platform.has_key?(ptech[2])
                      @tmptech = ""
                      CustomQueries.getTechnologies(ptech[0]).each do |ttech|
                        @include = IsValueInFilter(@hasfilter, 'tech', "#{projects.id}/#{roles.roles.id}/#{ptech[0]}/#{ttech[0]}", @filter)
                        if @include
                          @tmptech = @tmptech + ", " unless @tmptech == ""
                          @tmptech = @tmptech + ttech[2]
                          @platform[ptech[2]][ttech[2]] = ""
                        end
                      end
                      @techs = @techs + " (#{@tmptech})" unless @tmptech == ""
                  end             
                end
              end
              @tmpproject = @tmpproject.gsub('#WORK_TECH#', @techs)
            end
          end
          @projects = @projects + @tmpproject
        end
      end
      @template = @template.gsub('#TECH#', getTagAndTechs(@platform))
      @template = @template.gsub('#TOOLS#', getTagAndTechs(@tools))
      @template = @template.gsub('#KNOWLEDGES#', getTagAndTechs(@knowledge))

      @template = @template.gsub('#WORKDATA#', @projects)      

      @certs = ""
      @candidate.candidate_certifications.each do |certification|          
        @cert = @certdata
        @cert = @cert.gsub('#CERT_TITLE#', certification.certification.name) unless certification.certification.nil?
        @certs = @certs + @cert        
      end
      @template = @template.gsub('#CERTS#', @certs)            

      f.write(@template)    
    end    
    File.delete(@to) if File.exists?(@to)
    Zipper.zip(@from, @to)
    @to
  end
 
end