# app/services/application_service.rb
class ApplicationService
  def initialize
    @result = { success: false, errors: [] }
  end

  def self.call(*args)
    new(*args).call
  end

  protected

  attr_accessor :result

  def success!(data = {})
    result[:success] = true
    result.merge!(data)
    result
  end

  def failure!(errors)
    result[:success] = false
    result[:errors] = Array(errors)
    result
  end
end
