module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Yaxt"
    end
  end
end
