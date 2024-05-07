class TodosController < ApplicationController
  before_action :set_collected_statuses, only: [:index, :edit, :update, :new, :create]
  before_action :set_todo, only: %i[ show edit update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_todo

  skip_before_action :verify_authenticity_token, only: [:create, :edit, :update, :index, :destroy, :filter] 

  # GET /todos or /todos.json
  def index
    @todos = Todo.all
  end

  def filter
    has_no_filter = params[:status_filter].empty?
    @todos = unless has_no_filter
      Todo.where(current_status: filter_params)
    else
      Todo.all
    end
    
    respond_to do |format|
      format.turbo_stream do
        @todos
      end
    end
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todos_path, notice: "Todo was successfully updated." }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to todos_path, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:title, :description, :due_date, :current_status)
    end

    def set_collected_statuses
      @collected_statuses = Todo.current_statuses.to_h.collect {|s| [s[0].humanize, s[0]]}
    end

    def filter_params
      params.fetch(:status_filter)
    end

    def invalid_todo
      logger.error "Attempt to access invalid todo #{params[:id]}"
       redirect_to todos_path, notice: 'Invalid Todo'
    end

end
