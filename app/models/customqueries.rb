class CustomQueries < ActiveRecord::Base
	def self.getTags(customerID)
		self.connection.execute("SELECT DISTINCT p.tags_id as id, t.type_tag as type, t.name as name
			 FROM projects_tags p
			 JOIN tags t ON p.tags_id = t.id
			 WHERE p.projects_role_id in 
			 (
			 	SELECT a.id
			 	FROM projects_roles a
			 	JOIN projects b ON a.project_id = b.id
			 	WHERE candidate_id = #{customerID}
			 )")
	end

	def self.getProjectTags(project_id)
		self.connection.execute("SELECT DISTINCT p.tags_id as id, t.type_tag as type, t.name as name
			 FROM projects_tags p
			 JOIN tags t ON p.tags_id = t.id
			 WHERE p.projects_role_id = #{project_id}")
	end

	def self.getTechnologies(tag_id)
		self.connection.execute("SELECT DISTINCT id, lang_id, technology
			 FROM technologies
			 WHERE lang_id = #{tag_id}")
	end

	def self.deleteTechnologies(role_id, platform_id)
		self.connection.execute("DELETE FROM projects_tags_technologies 
				WHERE project_tag_id = #{role_id} AND tech_id in (
						SELECT id 
						FROM technologies
						WHERE lang_id = #{platform_id})")
	end

	def self.getCandidatesWithTheseTechs(techs)
		self.connection.execute("
			SELECT DISTINCT a.candidate_id
			FROM projects a
			LEFT JOIN projects_roles b ON b.project_id = a.id
			LEFT JOIN projects_tags c ON c.projects_role_id = b.id
			LEFT JOIN projects_tags_technologies d ON d.project_tag_id = b.id
			LEFT JOIN technologies e ON e.id = d.tech_id
			WHERE e.id in #{techs}")		
	end

	def self.getCandidatesWithTheseTools(tools)
		self.connection.execute("
			SELECT DISTINCT a.candidate_id
			FROM projects a
			LEFT JOIN projects_roles b ON b.project_id = a.id
			LEFT JOIN projects_tags c ON c.projects_role_id = b.id
			LEFT JOIN tags d ON d.id = c.tags_id
			WHERE d.id in #{tools} and d.type_tag = 1");
	end

	def self.getCandidatesWithTheseLanguages(languages)
		self.connection.execute("
			SELECT DISTINCT a.candidate_id
			FROM projects a
			LEFT JOIN projects_roles b ON b.project_id = a.id
			LEFT JOIN projects_tags c ON c.projects_role_id = b.id
			LEFT JOIN tags d ON d.id = c.tags_id
			WHERE d.id in #{languages} and d.type_tag = 3");
	end
end