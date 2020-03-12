module MetMuseum
  MetMuseumError = Class.new(StandardError)
  BadRequestError = Class.new(MetMuseumError)
  UnauthorizedError = Class.new(MetMuseumError)
  ForbiddenError = Class.new(MetMuseumError)
  NotFoundError = Class.new(MetMuseumError)
  UnprocessableEntityError = Class.new(MetMuseumError)
  ApiError = Class.new(MetMuseumError)
  TypeError = Class.new(MetMuseumError)
end
