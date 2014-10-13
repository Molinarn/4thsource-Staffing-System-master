require 'rubygems'
require 'zip/zip'
require 'find'
require 'fileutils'
require 'logger'

class Zipper
 
  def self.zip(dir, zip_dir, remove_after = false)
   @first = true
   Zip::ZipFile.open(zip_dir, Zip::ZipFile::CREATE)do |zipfile|
      Find.find(dir) do |path|
        if @first == true
          begin
            @first = false
            zipfile.add("[Content_Types].xml", dir + "/[Content_Types].xml")
            zipfile.add("_rels/.rels", dir + "/_rels/.rels")
          rescue Zip::ZipEntryExistsError
          end
        end
        Find.prune if File.basename(path)[0] == ?.
        dest = /#{dir}\/(\w.*)/.match(path)
        # Skip files if they exists
        begin
          zipfile.add(dest[1],path) if dest
        rescue Zip::ZipEntryExistsError
        end
      end
    end
    FileUtils.rm_rf(dir) if remove_after
  end
 
end