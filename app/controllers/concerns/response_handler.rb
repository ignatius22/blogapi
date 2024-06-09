module ResponseHandler
  def handle_response(result, success_status)
    if result[:success]
      render json: result[:post] || result[:posts], status: success_status
    else
      render json: { message: "Operation failed", errors: result[:errors] }, status: :unprocessable_entity
    end
  end
end
