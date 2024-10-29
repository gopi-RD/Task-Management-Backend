class Api::V1::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    tasks = Task.all
    if tasks
      render json: tasks, status: 200
    else
      render json: {message: "Tasks not found", status: 404}
    end
  end

  def show
    @task = Task.find_by(id: params[:id])
    if @task
      render json:@task, status: 200
    else
      render json: {message: "Task not found", status: 404}
    end  
  end 


  def create
    task = Task.new(
      title:task_params[:title],
      description:task_params[:description],
      checked: task_params[:checked]
    )
    if task.save
      render json:{message:"created task successfully", status:200}
    else
      render json:{
        err_msg: `Task creation failed #{task.errors.full_messages}`,
        status: 400
      }
    end
  end

  def update
    @task = Task.find_by(id: params[:id]) 
    if @task
      @task.update(title: params[:title],description: params[:description],checked: params[:checked])
      render json:{message:"updated task successfully", status:200}
    else
      render json: {message: "Task not found", status: 404}
    end  
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    if @task
      @task.destroy
      render json:{message:"task deleted successfully", status:200}
    else
      render json: {message: "Task not found", status: 404}
    end  
  end

 

  private
  def task_params
    params.require(:task).permit([
      :title,
      :description,
      :checked
  ])
  end
  
end
  
