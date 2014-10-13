class ComplexQuery < ActiveRecord::Base
  
  def initialize(param)
    @param = param
  end  
  
  
  def self.find
    @connector=" "
    @tecnologies=""
    @par = [ 1, 2, 3, 4, 5, 6, 7 ]
    @par.each do |t|
      @tecnologies=@tecnologies + @connector + "pt.tags_id=" + t.to_s
      @connector=" OR "
    end
    @sql ="SELECT * FROM projects_tags AS pt WHERE 1=1 AND ("+ @tecnologies + ")"
    self.connection.execute(sanitize_sql([@sql]))
  end
end