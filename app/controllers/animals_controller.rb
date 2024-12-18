class AnimalsController < ApplicationController
    # this line is just for test purposes
    skip_before_action :verify_authenticity_token, only: [:create, :update]
  
    def create
      @animal = Animal.new(name: params[:name], herd_id: params[:herd_id], status: "active")
  
      if @animal.save
        respond_to do |format|
          format.html
          format.turbo_stream
        end
      else
        handle_error(@animal.errors.full_messages)
      end
    end
  
    def update
      @animal = Animal.find(params[:id])
  
      if @animal.update(status: params[:status])
        respond_to do |format|
          format.html
          format.turbo_stream
        end
      else
        handle_error(@animal.errors.full_messages)
      end
    rescue ActiveRecord::RecordNotFound => e
      handle_error(["Animal not found."])
    rescue StandardError => e
      handle_error([e.message])
    end
  
    private
  
    def handle_error(errors)
      respond_to do |format|
        format.html { redirect_to root_path, alert: errors.to_sentence }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("events_stream", partial: "dashboard/error", locals: { errors: errors }) }
      end
    end
  end