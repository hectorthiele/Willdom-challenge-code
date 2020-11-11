module ApiResponder
  def api_response(object, status = :ok)
    render json: object, status: status
  end
end