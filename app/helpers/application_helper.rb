module ApplicationHelper
  # Return a title on a per-page basis.                 # Documentation comment
  def title                                             # Method definition
    base_title = "Ruby on Rails Tutorial Sample App"    # Variable assignment
    if @title.nil?                                      # Boolean test for nil
      base_title                                        # Implicit return
    else
      "#{base_title} | #{@title}"                       # String interpolation
    end
  end
  
  def link_to_resume(name, candidateId, options = {}, html_options = {})
      options.reverse_merge! :action     => 'show',
                             :method     => :get

      url = case options[:action]
              when 'summary'
                "/candidates/#{candidateId}/resume/summary"
              when 'experience'
                "/candidates/#{candidateId}/resume/experience"
              when 'experience-new'
                "/candidates/#{candidateId}/resume/experience/new"
              when 'experience-details'
                experienceId = options[:experienceId]
                "/candidates/#{candidateId}/resume/experience/#{experienceId}/details/new"
              when 'experience-tools'
                experienceId = options[:experienceId]
                "/candidates/#{candidateId}/resume/experience/#{experienceId}/skills/new"
              when '/skills'
                "/skills"
              when 'skills-new'
                "/skills/new"
              when 'languages'
                "/candidates/#{candidateId}/resume/languages"
              when 'languages-new'
                "/candidates/#{candidateId}/resume/languages/new"
              when 'resume'
                "/candidates/#{candidateId}/resume"
              when 'photo'
                "/candidates/#{candidateId}/resume/photo"
              when 'education'
                "/candidates/#{candidateId}/resume/education"
              when 'education-new'
                "/candidates/#{candidateId}/resume/education/new"
              when 'certification'
                "/candidates/#{candidateId}/candidate_certifications"
              when 'certification-new'
                "/candidates/#{candidateId}/candidate_certifications/new"
              when 'training'
                "/candidates/#{candidateId}/resume/training"
              when 'training-new'
                "/candidates/#{candidateId}/resume/training/new"
              when 'educ_degree'
                "/candidates/#{candidateId}/education_degree"
              when 'candidate_profiles'
                "/candidates/#{candidateId}/candidate_profiles"
            end
      link_to( name, url, options, html_options )
  end

  def link_to_candidates(name, candidateId, options = {}, html_options = {})
      options.reverse_merge! :action     => 'show',
                             :method     => :get

      url = case options[:action]
              when 'candidates'
                "/staff/#{candidateId}/candidates"
              end
      link_to(name, url, options, html_options)
  end
  
  def link_to_project(name, candidateId, options = {}, html_options = {})
      options.reverse_merge! :action     => 'show',
                             :method     => :get

      url = case options[:action]
              when 'index'
                "/candidates/#{candidateId}/projects"
              when 'new'
                "/candidates/#{candidateId}/projects/new"
            end
      link_to( name, url, options, html_options )
  end
  
  def marital_status_list
    [
      ['- Select one -', '0'],
      ['Single', 1],
      ['Married',2],
      ['Divorced',3],
      ['Widowed',4]
    ]
  end

  def degree_level_list
    [
      ['- Select one -', ''],
      ['Associate Degree', 'Associate Degree'],
      ["Bachelor's Degree","Bachelor's Degree"],
      ['Certification','Certification'],
      ['Doctorate','Doctorate'],
      ["Master's Degree","Master's Degree"],
      ['Coursework Completed','Coursework Completed'],
      ['Vocational','Vocational'],
      ['Vocacional Degree','Vocacional Degree']
    ]
  end

  def percentage_list
    [
      ['- Select one -', ''],
      ['10%','10'],
      ['20%','20'],
      ['30%','30'],
      ['40%','40'],
      ['50%','50'],
      ['60%','60'],
      ['70%','70'],
      ['80%','80'],
      ['90%','90'],
      ['100%','100']
    ]
  end
  
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

  def gender_list
    [
      ['- Select one -', 'Select one'],
      ['Male', 'M'],
      ['Female','F']
    ]
  end


  def tag_type_list
    [
      ['- Select one -', ''],
      ['Tool','1'],
      ['Knowledge', '2'],
      ['Technology', '3']
    ]
  end

  def locations_list
    [
      ['Merida','Merida'],
      ['Colima', 'Colima'],
      ['D.F.', 'D.F.']
    ]
  end

  def yes_or_no_list
    [
      ['- Select one -', '0'],
      ['Yes', 'Yes'],
      ['No','No']
    ]
  end
  
  def year_list
    array = Array.new
    for i in (Time.now.year - 1) .. (Time.now.year + 11)
      if i == (Time.now.year - 1)
        array.push ['- Select year -', '0']
      else
        array.push [i.to_s, i.to_s]
      end
    end
    return array
  end

  def country_list
    [
      ['- Select one -', '0'],
      ['Afghanistan','AF'],
      ['Aland Islands','AX'],
      ['Albania','AL'],
      ['Algeria','DZ'],
      ['American Samoa','AS'],
      ['Andorra','AD'],
      ['Angola','AO'],
      ['Anguilla','AI'],
      ['Antarctica','AQ'],
      ['Antigua and Barbuda','AG'],
      ['Argentina','AR'],
      ['Armenia','AM'],
      ['Aruba','AW'],
      ['Australia','AU'],
      ['Austria','AT'],
      ['Azerbaijan','AZ'],
      ['Bahamas','BS'],
      ['Bahrain','BH'],
      ['Bangladesh','BD'],
      ['Barbados','BB'],
      ['Belarus','BY'],
      ['Belgium','BE'],
      ['Belize','BZ'],
      ['Benin','BJ'],
      ['Bermuda','BM'],
      ['Bhutan','BT'],
      ['Bolivia','BO'],
      ['Bosnia and Herzegovina','BA'],
      ['Botswana','BW'],
      ['Bouvet Island','BV'],
      ['Brazil','BR'],
      ['British Indian Ocean Territory','IO'],
      ['Brunei Darussalam','BN'],
      ['Bulgaria','BG'],
      ['Burkina Faso','BF'],
      ['Burundi','BI'],
      ['Cambodia','KH'],
      ['Cameroon','CM'],
      ['Canada','CA'],
      ['Cape Verde','CV'],
      ['Cayman Islands','KY'],
      ['Central African Republic','CF'],
      ['Chad','TD'],
      ['Chile','CL'],
      ['China','CN'],
      ['Christmas Island','CX'],
      ['Cocos (Keeling) Islands','CC'],
      ['Colombia','CO'],
      ['Comoros','KM'],
      ['Congo','CG'],
      ['Congo, The Democratic Republic of The','CD'],
      ['Cook Islands','CK'],
      ['Costa Rica','CR'],
      ['Cote D ivoire','CI'],
      ['Croatia','HR'],
      ['Cuba','CU'],
      ['Cyprus','CY'],
      ['Czech Republic','CZ'],
      ['Denmark','DK'],
      ['Djibouti','DJ'],
      ['Dominica','DM'],
      ['Dominican Republic','DO'],
      ['Ecuador','EC'],
      ['Egypt','EG'],
      ['El Salvador','SV'],
      ['Equatorial Guinea','GQ'],
      ['Eritrea','ER'],
      ['Estonia','EE'],
      ['Ethiopia','ET'],
      ['Falkland Islands (Malvinas)','FK'],
      ['Faroe Islands','FO'],
      ['Fiji','FJ'],
      ['Finland','FI'],
      ['France','FR'],
      ['French Guiana','GF'],
      ['French Polynesia','PF'],
      ['French Southern Territories','TF'],
      ['Gabon','GA'],
      ['Gambia','GM'],
      ['Georgia','GE'],
      ['Germany','DE'],
      ['Ghana','GH'],
      ['Gibraltar','GI'],
      ['Greece','GR'],
      ['Greenland','GL'],
      ['Grenada','GD'],
      ['Guadeloupe','GP'],
      ['Guam','GU'],
      ['Guatemala','GT'],
      ['Guernsey','GG'],
      ['Guinea','GN'],
      ['Guinea-bissau','GW'],
      ['Guyana','GY'],
      ['Haiti','HT'],
      ['Heard Island and Mcdonald Islands','HM'],
      ['Holy See (Vatican City State)','VA'],
      ['Honduras','HN'],
      ['Hong Kong','HK'],
      ['Hungary','HU'],
      ['Iceland','IS'],
      ['India','IN'],
      ['Indonesia','ID'],
      ['Islamic Republic of Iran','IR'],
      ['Iraq','IQ'],
      ['Ireland','IE'],
      ['Isle of Man','IM'],
      ['Israel','IL'],
      ['Italy','IT'],
      ['Jamaica','JM'],
      ['Japan','JP'],
      ['Jersey','JE'],
      ['Jordan','JO'],
      ['Kazakhstan','KZ'],
      ['Kenya','KE'],
      ['Kiribati','KI'],
      ['Democratic Peoples Republic of Korea','KP'],
      ['Republic of Korea','KR'],
      ['Kuwait','KW'],
      ['Kyrgyzstan','KG'],
      ['Lao Peoples Democratic Republic','LA'],
      ['Latvia','LV'],
      ['Lebanon','LB'],
      ['Lesotho','LS'],
      ['Liberia','LR'],
      ['Libyan Arab Jamahiriya','LY'],
      ['Liechtenstein','LI'],
      ['Lithuania','LT'],
      ['Luxembourg','LU'],
      ['Macao','MO'],
      ['Macedonia, The Former Yugoslav Republic of','MK'],
      ['Madagascar','MG'],
      ['Malawi','MW'],
      ['Malaysia','MY'],
      ['Maldives','MV'],
      ['Mali','ML'],
      ['Malta','MT'],
      ['Marshall Islands','MH'],
      ['Martinique','MQ'],
      ['Mauritania','MR'],
      ['Mauritius','MU'],
      ['Mayotte','YT'],
      ['Mexico','MX'],
      ['Federated States of Micronesia','FM'], 
      ['Republic of Moldova','MD'],
      ['Monaco','MC'],
      ['Mongolia','MN'],
      ['Montenegro','ME'],
      ['Montserrat','MS'],
      ['Morocco','MA'],
      ['Mozambique','MZ'],
      ['Myanmar','MM'],
      ['Namibia','NA'],
      ['Nauru','NR'],
      ['Nepal','NP'],
      ['Netherlands','NL'],
      ['Netherlands Antilles','AN'],
      ['New Caledonia','NC'],
      ['New Zealand','NZ'],
      ['Nicaragua','NI'],
      ['Niger','NE'],
      ['Nigeria','NG'],
      ['Niue','NU'],
      ['Norfolk Island','NF'],
      ['Northern Mariana Islands','MP'],
      ['Norway','NO'],
      ['Oman','OM'],
      ['Pakistan','PK'],
      ['Palau','PW'],
      ['Palestinian Territory, Occupied','PS'],
      ['Panama','PA'],
      ['Papua New Guinea','PG'],
      ['Paraguay','PY'],
      ['Peru','PE'],
      ['Philippines','PH'],
      ['Pitcairn','PN'],
      ['Poland','PL'],
      ['Portugal','PT'],
      ['Puerto Rico','PR'],
      ['Qatar','QA'],
      ['Reunion','RE'],
      ['Romania','RO'],
      ['Russian Federation','RU'],
      ['Rwanda','RW'],
      ['Saint Helena','SH'],
      ['Saint Kitts and Nevis','KN'],
      ['Saint Lucia','LC'],
      ['Saint Pierre and Miquelon','PM'],
      ['Saint Vincent and The Grenadines','VC'],
      ['Samoa','WS'],
      ['San Marino','SM'],
      ['Sao Tome and Principe','ST'],
      ['Saudi Arabia','SA'],
      ['Senegal','SN'],
      ['Serbia','RS'],
      ['Seychelles','SC'],
      ['Sierra Leone','SL'],
      ['Singapore','SG'],
      ['Slovakia','SK'],
      ['Slovenia','SI'],
      ['Solomon Islands','SB'],
      ['Somalia','SO'],
      ['South Africa','ZA'],
      ['South Georgia and The South Sandwich Islands','GS'],
      ['Spain','ES'],
      ['Sri Lanka','LK'],
      ['Sudan','SD'],
      ['Suriname','SR'],
      ['Svalbard and Jan Mayen','SJ'],
      ['Swaziland','SZ'],
      ['Sweden','SE'],
      ['Switzerland','CH'],
      ['Syrian Arab Republic','SY'],
      ['Taiwan, Province of China','TW'],
      ['Tajikistan','TJ'],
      ['Tanzania, United Republic of','TZ'],
      ['Thailand''TH'],
      ['Timor-leste','TL'],
      ['Togo','TG'],
      ['Tokelau','TK'],
      ['Tonga','TO'],
      ['Trinidad and Tobago','TT'],
      ['Tunisia','TN'],
      ['Turkey','TR'],
      ['Turkmenistan','TM'],
      ['Turks and Caicos Islands','TC'],
      ['Tuvalu','TV'],
      ['Uganda','UG'],
      ['Ukraine','UA'],
      ['United Arab Emirates','AE'],
      ['United Kingdom','GB'],
      ['United States','US'],
      ['United States Minor Outlying Islands','UM'],
      ['Uruguay','UY'],
      ['Uzbekistan','UZ'],
      ['Vanuatu','VU'],
      ['Venezuela','VE'],
      ['Vietnam','VN'],
      ['Virgin Islands, British','VG'],
      ['Virgin Islands, U.S.','VI'],
      ['Wallis and Futuna','WF'],
      ['Western Sahara','EH'],
      ['Yemen','YE'],
      ['Zambia','ZM'],
      ['Zimbabwe','ZW']
    ]
  end

  def job_status_list
    [
      ['- Select one -',''],
      ['onHold',0],
      ['Open',1],
      ['Closed',2],
      ['Cancel',3]
    ]
  end
   
  def time_blocks_list
    [
      ['- Select one -',''],
      ['1',1],
      ['2',2],
      ['3',3],
      ['4',4],
      ['5',5],
      ['6',6],
      ['1',7],
      ['2',8],
      ['3',9],
      ['4',10],
      ['5',11],
      ['6',12]     
    ]
  end

   
    def time_periods_list
    [
      ['- Select one -',''],
      ['days','days'],
      ['weeks','weeks'],
      ['months','months'] 
    ]
  end

  def sanitized_object_name(object_name)
    object_name.gsub("/][|[^-a-zA-Z0-9:.]/","_").sub("/_$/","")
  end
 
  def sanitized_method_name(method_name)
    method_name.sub("/?$/", "")
  end
 
  def form_tag_id(object_name, method_name)
    "#{sanitized_object_name(object_name.to_s)}_#{sanitized_method_name(method_name.to_s)}"
  end

end
