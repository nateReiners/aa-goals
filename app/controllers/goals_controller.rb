class GoalsController < ApplicationController
  before_action :require_sign_in!

  def new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  def show
    @goal = Goal.find(params[:id])
  end

  private

  def goal_params
    params.require(:goal).permit(:body, :title, :user_id)
  end

end
