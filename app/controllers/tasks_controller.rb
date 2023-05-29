class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        year = Time.current.year
        month = params[:month].to_i if params[:month].present?
        @current_month = Date.new(year, month, 1) rescue Date.current.beginning_of_month
        @tasks = Task.where(due_date: @current_month.beginning_of_month..@current_month.end_of_month).order(:due_date)
        @prev_month = @current_month.prev_month
        @next_month = @current_month.next_month
    end

    def show
        @task = Task.find(params[:id])
    end

    def new
    @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        if @task.save
            redirect_to tasks_path, notice: "タスクが作成されました。"
        else
            render :new
        end
    end

    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            redirect_to task_path(@task), notice: "タスクが更新されました。"
        else
            render :edit
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to tasks_path, notice: "タスクが削除されました。"
    end
    
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    

    def task_params
    params.require(:task).permit(:title, :description, :priority, :due_date)
    end
end
