class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  # GET /searches
  # GET /searches.json
  def index
    # temporary to show past searches
    @searches = Search.all

    # allows search form to load on index page (basically taken from /searches/new)
    # @search = Search.new

  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  # GET /searches/new
  def new
    @search = Search.new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    search_term = search_params["searched_name"]
    search_artist(search_term)

    # @search = Search.new(search_params)

    # respond_to do |format|
    #   if @search.save
    #     format.html { redirect_to @search, notice: 'Search was successfully created.' }
    #     format.json { render :show, status: :created, location: @search }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @search.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def search_params
      params.require(:search).permit(:searched_name)
    end

    def search_artist(search_term)
      sanitized_search_term = search_term.html_safe
      
      # setup connection to API
      conn = Faraday.new(
        url: 'http://theaudiodb.com/api/v1/json/1/',
        headers: {'Content-Type' => 'application/json'}
      ) do |conn|
        # specify to follow redirects so that cloudfare won't cause errors
        conn.use FaradayMiddleware::FollowRedirects, limit: 5
        conn.adapter Faraday.default_adapter
      end

      # make request to API
      response = conn.get('search.php') do |req|
        req.params["s"] = sanitized_search_term
      end

      # parse response into JSON
      json_response = JSON.parse(response.body)
      
      # redirect to search page if response was unsuccessful or empty
      if response.status != 200 || json_response["artists"].nil?
        # need to show alert on redirect because of bad or empty response
        redirect_to :controller => 'searches', :action => 'new' 
      end

      # log response for debugging
      puts json_response
    end
end
