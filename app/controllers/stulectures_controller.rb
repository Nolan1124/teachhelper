class StulecturesController < BaseApplicationController
  before_action :set_stulecture, only: [:show, :edit, :update, :destroy]

  # GET /stulectures
  # GET /stulectures.json
  
   def findkey
    key=session[:secret_key]
    lectures = Lecture.find_by(secret_key: key)
    return lectures
  end
  
  def download
    file_name=params[:url]
    file_path = File.join(Rails.root, "public")
    send_file(File.join(file_path, file_name))
  end
  
  def index
    key=session[:secret_key]
    @stulectures = Lecture.find_by(secret_key: key)
  end

  # GET /stulectures/1
  # GET /stulectures/1.json
  def show
  end

  # GET /stulectures/new
  def new
    @stulecture = Stulecture.new
  end

  # GET /stulectures/1/edit
  def edit
  end

  # POST /stulectures
  # POST /stulectures.json
  def create
    @stulecture = Stulecture.new(stulecture_params)

    respond_to do |format|
      if @stulecture.save
        format.html { redirect_to @stulecture, notice: 'Stulecture was successfully created.' }
        format.json { render :show, status: :created, location: @stulecture }
      else
        format.html { render :new }
        format.json { render json: @stulecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stulectures/1
  # PATCH/PUT /stulectures/1.json
  def update
    respond_to do |format|
      if @stulecture.update(stulecture_params)
        format.html { redirect_to @stulecture, notice: 'Stulecture was successfully updated.' }
        format.json { render :show, status: :ok, location: @stulecture }
      else
        format.html { render :edit }
        format.json { render json: @stulecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stulectures/1
  # DELETE /stulectures/1.json
  def destroy
    @stulecture.destroy
    respond_to do |format|
      format.html { redirect_to stulectures_url, notice: 'Stulecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stulecture
      @stulecture = Stulecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stulecture_params
      params.fetch(:stulecture, {})
    end
end
