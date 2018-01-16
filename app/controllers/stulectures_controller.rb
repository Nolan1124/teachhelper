class StulecturesController < BaseApplicationController

  def download
    file_name=params[:url]
    file_path = File.join(Rails.root, "public")
    send_file(File.join(file_path, file_name))
  end
  
  # GET /stulectures
  # GET /stulectures.json
  def index
    key=session[:secret_key]
    @stulectures = Lecture.find_by(secret_key: key)
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def stulecture_params
      params.fetch(:stulecture, {})
    end
end
