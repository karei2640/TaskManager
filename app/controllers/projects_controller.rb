class ProjectsController < ApplicationController
    def index
      year = Time.current.year
      month = params[:month].to_i if params[:month].present?
      @current_month = Date.new(year, month, 1) rescue Date.current.beginning_of_month
      @projects = Project.where(due_date: @current_month.beginning_of_month..@current_month.end_of_month).order(:due_date)
      @prev_month = @current_month.prev_month
      @next_month = @current_month.next_month
    end
  
    def new
      @project = Project.new
    end

    def show
      @project = Project.find(params[:id])
    end
  
    def create
      @project = Project.new(project_params)
      if @project.save
        redirect_to projects_path, notice: "プロジェクトが作成されました。"
      else
        render :new
      end
    end
  
    private
  
    def project_params
      params.require(:project).permit(:title, :description, :due_date)
    end
end