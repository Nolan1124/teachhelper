class Lecture < ActiveRecord::Base
    
    
    '''
    def initialize(uploaded_file)
        ext = File.extname(uploaded_file.original_filename)
        @tmp_destination = "#{Rails.root}/tmp/tag-import#{ext}"
        @file_path = save_file_to_tmp(uploaded_file)
        @file = File.new(@file_path)
        read_file(@file)
    end

    def save_file_to_tmp(uploaded_file)
        FileUtils.mv(uploaded_file.tempfile, @tmp_destination )
        @tmp_destination
    end

  def read_file(file)
    @spreadsheet = open_spreadsheet(file)
    @spreadsheet.each_with_pagename do |name,sheet|
      Rails.logger.debug( sheet )
    end
  end

  def open_spreadsheet(file)
    case File.extname(file.path)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type"
    end
  end
    '''
    

end
