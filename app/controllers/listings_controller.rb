class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :authenticate_user!


  # GET /listings or /listings.json
  def index
    if params[:query]
      search_term = "%#{params[:query]}%"
      @listings = Listing
                  .where(["title ILIKE ? OR description  ILIKE ? OR location ILIKE ?", search_term, search_term, search_term])
                  # .where("title ILIKE ?", search_term)
                  # .or(Listing.where("description ILIKE ?", search_term))
                  #.where("price ILIKE ?", search_term) # decimal needs typecast to query
                  #.or(Listing.where("location ILIKE ?", search_term))
                  .order('created_at DESC')
      @search = search_term
    else
      @listings = Listing.all.order('created_at DESC')
    end
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @listing.images.attach(params[:images])

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy!

    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:title, :description, :location, :user_id, :category_id, :price, :query, images: [])
    end
end
