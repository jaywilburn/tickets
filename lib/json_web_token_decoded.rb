class JsonWebTokenDecoded < HashWithIndifferentAccess
  def expired?
    self[:exp] <= Time.now.to_i
  end
end
