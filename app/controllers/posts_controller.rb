class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user_l!, except: [ :index, :show ]

  # GET /posts or /posts.json
  def index
    if user_l_signed_in?
      # Show all posts with future dates to logged-in users
      @posts = Post.where("event_date >= ?", Date.today).order("event_date")
    else
      # Show only visible posts with future dates to guests
      @posts = Post.where(visibility: true).where("event_date >= ?", Date.today).order("event_date")
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @bands = @post.bands
  end

  # GET /posts/new
  def new
    @genres = load_genres
    @bands = Band.all # Fetch all bands for the form
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @genres = load_genres
    @bands = Band.all # Fetch all bands for the form
  end

  # POST /posts or /posts.json
  def create
    @genres = load_genres
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!
    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Load genres from a JSON file
  def load_genres
    genres_file = Rails.root.join("config", "genres.json")
    JSON.parse(File.read(genres_file))["genres"]
  end

  # Only allow a list of trusted parameters through.
  def post_params
    genres = params[:post][:genre].reject(&:blank?).join(" / ")
    params[:post][:genre] = genres
    params.require(:post).permit(:event_name, :time, :event_date, :membership_required, :visibility, :suggested_donation, :genre, :image, :show_poster, band_ids: [])
  end
end
