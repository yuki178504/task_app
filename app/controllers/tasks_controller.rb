class TasksController < ApplicationController

helper_method :sort_column, :sort_direction

  def index
    @tasks = Task.order("#{sort_column} #{sort_direction}")
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'title'
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:title, :start_date, :end_date, :all_day, :introduction))
    if @task.save
      flash[:notice] = "登録が完了しました!"
      redirect_to :tasks
    else
      flash.now[:alert] = "⚠︎  登録に失敗しました!"
      render "new"
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(params.require(:task).permit(:title, :start_date, :end_date, :all_day, :introduction))
      flash[:notice] = "編集が完了しました!"
      redirect_to :tasks
    else
      flash.now[:alert] = "⚠️  編集に失敗しました!"
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "削除に成功しました！"
    redirect_to :tasks
  end
end
