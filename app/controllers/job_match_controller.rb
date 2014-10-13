class JobMatchController < ApplicationController

  @trace = true
	
    def index
        set_my_wall(nil)
        set_wall_candidate(nil)
        @jobs = Job.all    
        @match = JobMatch.all
        
        if(params[:jobSearch]!=nil and params[:matchPercentage]!=nil)
            if(@jobId != "Options" and @matchPercentage!="Options")
              match
            end
        end
    end

  #Metodo para busqueda
    def search        
        @jobId = params[:jobSearch]  
            
        #@tools = Tag.joins(:job_match).where(:job_id => @jobId)
        #@tools = Tag.joins("inner join job_matches jm on tags.id = jm.tag_id").where("jm.job_id=? and tags.type_tag=?",@jobId,1)
        @tools = Tag.find_by_sql(["select t.id, t.name, jm.time_required from tags t inner join job_matches jm on t.id = jm.tag_id where jm.job_id=? and t.type_tag=?",@jobId,1])
        @knowledges = Tag.find_by_sql(["select t.id, t.name, jm.time_required from tags t inner join job_matches jm on t.id = jm.tag_id where jm.job_id=? and t.type_tag=?",@jobId,2])
        @platforms = Tag.find_by_sql(["select t.id, t.name, jm.time_required from tags t inner join job_matches jm on t.id = jm.tag_id where jm.job_id=? and t.type_tag=?",@jobId,3])
        @jobMatchs = JobMatch.joins(:job,:tag).where(:job_id => @jobId) 
              
        @platforms.each do |p|
#select * from technologies inner join tags on technologies.lang_id = tags.id inner join job_matches on job_matches.tag_id = tags.id where job_id = 61;
          @frameworks = Technology.find_by_sql(["select ta.id, t.technology, jm.time_required from technologies t inner join tags ta on t.lang_id = ta.id inner join job_matches jm on jm.tag_id = ta.id where jm.job_id=? and t.lang_id=?", @jobId, p])         
          #@frameworks = Technology.joins("inner join tags t on t.id = lang_id").where("lang_id=?", p)
        end

        render :search, :layout => false
    end

    def match        
        @jobId = params[:jobSearch]
        @matchPercentage = params[:matchPercentage]        
        auxStr = params[:matchPercentage]
        @matchPercentage = auxStr[0,auxStr.index('&')]
        strValues = auxStr.sub(@matchPercentage, '')        
        #strValues = "t_16=7&t_21=6"
        
        #Recupera el Job y las capacidades o caracteristicas que requier ej. C, C#, Pascal Pyton, etc
        @jobMatchs = JobMatch.joins(:job,:tag).where(:job_id => @jobId)            
        #Determina el numero minimo de tags a cumplir
        @countMatchs = (@jobMatchs.count * @matchPercentage.to_i)/100
        @candidateHash = defineCandidates   
        
        #@newDefine = 

        showCandidate(strValues)
        @listCandidates = CandidatesProfile.joins(:candidate).where(:candidate_id => @candidateHashLocal.keys).group(:first_name)

        render :match, :layout => false
    end
end

def showCandidate(strValues)
  auxHash = Hash.new()

  
  strValues = strValues.sub('&','')


  strValues = strValues.gsub("t_", "")
  valuesArray = strValues.split("&")
 
  valuesArray.each do |param|
    tagId = param[0,param.index('=')]
    value = param[param.index('=')+1,param.length]
    
    #Searching the tagId
    @candidateHashLocal.each_pair do |k, v|   
          key = "#{k}"
          auxHash = v
          if(auxHash[tagId]!=nil)
            auxHash["first_name"]=Candidate.where(:id=>key)[0].first_name
            auxHash["first_last_name"]=Candidate.where(:id=>key)[0].first_last_name            
            if(auxHash[tagId].to_d>=value.to_d/10)
              auxHash["show"]="yes"
              #auxHash["resumeTag"]="TagId: " + tagId + " DB Value: " + auxHash[tagId] + " SearchValue: " + value.to_s
              logger.debug "TagId: " + tagId + " DB Value: " + auxHash[tagId] + " SearchValue: " + value.to_s
            else 
              logger.debug "TagId: " + tagId + " DB Value: " + auxHash[tagId] + " SearchValue: " + value.to_s
            end 
          end
      end
  end
end



#Metodo que calculara/definira aquellos candidatos que cumplan con el minimo de requisitos
def defineCandidates
    
    @candidateHashLocal = Hash.new()
    @arrayCandidates = Array.new()
    @candidateTags = RCandidateTag.joins(:tag,:candidates_profile)
    
    @candidateTags.each do |candidate|
       if (@trace)
         logger.debug "==Procesando candidato:" + candidate.candidates_profile_id.to_s
         logger.debug "====candidate.tag_id:" + candidate.tag_id.to_s
       end 

       @jobMatchs.each do |job|
         if (@trace)
           logger.debug "======job.tag_id:" + job.tag_id.to_s
         end 
        
         if candidate.tag_id==job.tag_id
           incrementTagToCandidate(candidate.candidates_profile_id)
         end 
       end#fin del ciclo de jobs
    end #fin del ciclo de candidates

   #retrieveBestCandidatesInVector()
   retrieveBestCandidatesInHash() #En este punto ya paso el primer punto. %minimo de tags requeridos
   getCandidateDetail
   
   return @candidateHashLocal  
end  


def insertCandidate(candidate_id)
  if(!@arrayCandidates.include?(candidate_id))
    @arrayCandidates.push(candidate_id)
  end 
end

#Este metodo insertara el candidato, asi como la cantidad con la que cumplio de las condiciones de busqueda. Todos los candidatos
#que cuenten con tags seran insertados aqui
def incrementTagToCandidate(candidate_id)
  @trace = true
 
  if(!@candidateHashLocal.has_key? candidate_id.to_s)
    if (@trace)
      logger.debug "====Insertando candidato:" + candidate_id.to_s 
    end 
    @candidateHashLocal.store(candidate_id.to_s,1)
  else 
    if (@trace)
      logger.debug "====Buscando candidato:" + candidate_id.to_s
    end 
   
    @acumLocal = @candidateHashLocal[candidate_id.to_s]  
    @acumLocal = @acumLocal + 1
    @candidateHashLocal.store(candidate_id.to_s,@acumLocal)
    if (@trace)
        logger.debug "====Nuevo valor guardado:" + @acumLocal.to_s
    end
  end
end

#Metodo por si se desea la informacion en un vector con los ids de los candidatos sin importar el numero de tags con los que cuenta
def retrieveBestCandidatesInVector()
  if(@candidateHashLocal!=nil)
        @candidateHashLocal.each_pair do |k, v|   
            #puts "Key: #{k}, Value: #{v}" 
            key = "#{k}"
            value= "#{v}"
           
            if(value.to_i>=@countMatchs)
              insertCandidate(key.to_i)
            end   
        end
  end 
end

#En el mismo hash principal elimina los que no cumplen con lo minimo en lugar de recuperarlos en un vector
def retrieveBestCandidatesInHash()
  if(@candidateHashLocal!=nil)
        @candidateHashLocal.each_pair do |k, v|   
            key = "#{k}"
            value= "#{v}"
            if(value.to_i<@countMatchs)
              deleteCandidate(key)
            end   
        end
  end 
end

def deleteCandidate(key)
    if(@trace)
        logger.debug "====Eliminando candidato con llave:" + key.to_s
    end 
    
    @candidateHashLocal.delete(key)   
end

#Llenara un hashTable correspondiente a un candidato. Donde tendra la siguiente estructura:
#tag-id => Experience
#Ejemplo 
#11 (CVS control version system) - 4 años
def getCandidateDetail()
  
  auxHash = Hash.new
  @candidateHashLocal.each_pair do |k, v|   
    candidateId = "#{k}"
    numTags= "#{v}"

    auxHash.store(candidateId, getCandidateExperience(candidateId,numTags))

  end 
  @candidateHashLocal = auxHash;         
end



def getCandidateExperience(candidateId, numTags)
  candidateHashExperience = Hash.new
  candidateHashExperience = readExperience(candidateId)

  if(numTags.to_i >=@countMatchs)
      percentage = 100
  else
      percentage = (100 * numTags.to_i)/@countMatchs
  end 

  candidateHashExperience.store("numberOfTags",numTags)
  candidateHashExperience.store("percentage",percentage)
  candidateHashExperience.store("show","no")
  return candidateHashExperience;
end 


def readExperience(candidateId)
  candidateHashExperience = Hash.new()
  query = ProjectsTag.find_by_sql(["SELECT DISTINCT pt.id as tagId, cp.profiledata as pd
      ,DATEDIFF(pt.date_out,pt.date_in)/365 AS exp 
      FROM projects_tags pt
      JOIN projects_roles pr ON pt.projects_role_id = pr.id
      JOIN projects p ON pr.project_id = p.id
      JOIN candidates c ON p.candidate_id = c.id
      JOIN candidates_profiles cp ON c.id = cp.candidate_id
      WHERE c.id = ?",candidateId])

  logger.debug "Procesando candidato: " + candidateId

  query.each do |candidateInfo|
    if(candidateInfo.pd!="")
      #logger.debug "Tags: " + candidateInfo.pd
      arrayTags = splitString(candidateInfo.pd)
      #logger.debug "ArrayTags: " + arrayTags.to_s
      arrayTags.each do |tagId|
        #logger.debug "Procesando Tag: " + tagId
        if(!candidateHashExperience.has_key? tagId)
          #logger.debug "Insertando Tag: " + tagId + " con valor " + candidateInfo.exp.to_s
          candidateHashExperience.store(tagId,candidateInfo.exp.ceil(2))
        else
          acumLocal = candidateHashExperience[tagId]
          #logger.debug "Valor leido al Tag: " + tagId + " con valor " + acumLocal.ceil(2).to_s
          acumLocal = acumLocal.add(candidateInfo.exp,2)
          #logger.debug "Insertando Nuevo valor al Tag: " + tagId + " con valor " + acumLocal.ceil(2).to_s
          candidateHashExperience.store(tagId,acumLocal.ceil(2))
        end 
      end
    else
      logger.debug "================Sin informacion para el candidato " + candidateId
    end
  end

  candidateHashExperience = cleanBigDecimalDetails(candidateHashExperience)
  return candidateHashExperience
end

#Este metodo lo cree porque no encontre la forma de quitarle toda la notacion de un BigDecimal en ruby.
#Solo transforma la notacion de un bigDecimal de ruby a algo legible ej. 10.4
def cleanBigDecimalDetails(hashLocal)
  auxHash = Hash.new
  hashLocal.each_pair do |k, v|   
    tagId = "#{k}"
    value= "#{v}"
    auxHash.store(tagId,value)
  end 
  return auxHash
end


  #Input example "{#tag:66/13/15#}{#undefined:undefined#}{#role:66/13#}{#project:66#}{#tag:66/13/24#}{#undefined:undefined#}{#tech:66/13/4/6#}{#tag:66/13/224#}"
def splitString(strTags)
  trace = false
  strAuxTags = "";
  strTagPartial = "";
  arrayTagsLocal = Array.new()

  
  while strTags.include?"{#tag:"
      initPos = strTags.index('{#tag:')
      if(initPos>0)
        strTags[0..initPos-1] = ""
        initPos = 0
      end
      endPos = strTags.index('#}')+2
      strTagPartial = strTags[initPos,endPos]
      strTags[0..endPos] = ""
      arrayTagsLocal.push(splitTag(strTagPartial))
      if(trace)
        logger.debug "====strTags:" + strTags.to_s
        logger.debug "====strTagPartial:" + strTagPartial.to_s
        logger.debug "====strTags:" + strTags.to_s
      end
  end
  return arrayTagsLocal
end

#Input {#tag:66/13/5#}
#Output 5 
#This method will receive input tag as JSON and the output will be the tag id 
def splitTag(strTag)
  initPos = strTag.rindex('/')+1
  endPos = strTag.length-3
  tag = strTag[initPos..endPos]
  return tag
end

