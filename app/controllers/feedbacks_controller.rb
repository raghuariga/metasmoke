class FeedbacksController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :verify_admin, only: [:clear, :delete]
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :check_if_smokedetector, :only => :create

  protect_from_forgery :except => [:create]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all
  end

  def clear
    @post = Post.find(params[:id])
    @feedbacks = Feedback.unscoped.where(:post_id => params[:id])
    @sites = [@post.site]

    raise ActionController::RoutingError.new('Not Found') if @post.nil?
  end

  def delete
    f = Feedback.find params[:id]

    f.post.reasons.each do |reason|
      expire_fragment(reason)
    end

    f.is_invalidated = true
    f.invalidated_by = current_user.id
    f.invalidated_at = DateTime.now
    f.save

    redirect_to clear_post_feedback_path(f.post_id)
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)

    @ignored = IgnoredUser.find_by_user_name(@feedback.user_name)
    if @ignored && @ignored.is_ignored == true
      return
    end

    post_link = feedback_params[:post_link]

    post = Post.find_by_link(post_link)

    if post == nil
      render :text => "Error: No post found for link" and return
    end

    post.reasons.each do |reason|
      expire_fragment(reason)
    end

    expire_fragment("post" + post.id.to_s)

    @feedback.post = post

    respond_to do |format|
      if @feedback.save
        format.json { render :show, status: :created, :text => "OK" }
      else
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:message_link, :user_name, :user_link, :feedback_type, :post_link)
    end
end
