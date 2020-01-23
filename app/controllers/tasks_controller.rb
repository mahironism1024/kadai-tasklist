class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show, :edit, :update, :destroy]
    
    def index
        if logged_in?
            @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
        end
    end
    
    def show
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
        binding.pry
        @task.destroy
        
        flash[:success] = "タスクが削除されました"
        redirect_to tasks_url
    end
    
    private
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            flash[:danger] = "他ユーザーが作成したタスクにはアクセスできません。"
            redirect_to root_url
        end
    end
    
    def message_params
        params.require(:task).permit(:content,:status)
    end
    
end
