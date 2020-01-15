class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        @tasks = Task.all
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(message_params)
        
        if @task.save
            flash[:success] = "タスクの登録が完了しました"
            redirect_to tasks_path
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
        @task = Task.find(params[:id])
    end
    
    def message_params
        params.require(:task).permit(:content)
    end
    
end
