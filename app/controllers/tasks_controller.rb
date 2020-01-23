class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        if logged_in?
            @task = current_user.tasks.build
            @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
        end
    end
    
    def show
        unless @current_user.id == @task.user_id
            redirect_to root_url
        end
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(message_params)
        
        if @task.save
            flash[:success] = "タスクの登録が完了しました"
            redirect_to root_url
        else
            flash.now[:faild] = "タスクの登録に失敗しました"
            render :new
        end       
    end
    
    def edit
    end
    
    def update
        if @task.update(message_params)
            flash[:success] = "タスクが更新されました"
            redirect_to task_path
        else
            flash.now[:danger] = "タスクの更新に失敗しました"
            render :edit
        end
    end

    def destroy
        @task.destroy
        
        flash[:success] = "タスクが削除されました"
        redirect_to tasks_url
    end
    
    private
    
    def set_task
        @task = Task.find_by(id: params[:id])
        if @task == nil
            redirect_to root_url
        end
    end
    
    def message_params
        params.require(:task).permit(:content,:status)
    end
    
end
