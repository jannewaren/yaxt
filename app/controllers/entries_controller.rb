class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :destroy, :search]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(name: entry_params[:name], description: entry_params[:description])

    # User input does not include all the necessary data, populating it here
    @entry.filename_user = params[:entry][:xml].original_filename
    @entry.filename_system = Time.now.to_i.to_s+'_'+SecureRandom.hex.to_s+'.xml'
    upload(params[:entry][:xml], @entry.filename_system)
    @entry.filesize = params[:entry][:xml].size
    @entry.upload_ip = request.remote_ip

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
    end
  end

  # POST /entries/1/search
  def search
    @found = ''

    if @entry.element_exists?(params[:node].to_s)
      @found = 'Found it!'
    else
      @found = 'Not found!'
    end

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:name, :description, :xml)
    end

    ## Upload file
    #
    # Saves file to disk (/public/uploaded_files). Requires a filename to be used.
    def upload(uploaded_io, filename)
      File.open(Rails.root.join('public', 'uploaded_files', filename), 'wb') do |file|
        file.write(uploaded_io.read)
        file.close
      end
    end
end
