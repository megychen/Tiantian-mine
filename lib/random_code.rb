module RandomCode
  class << self
    def generate_utoken len = 8
      a = lambda { rand(36).to_s(36) }
      token = ""
      len.times { |t| token << a.call.to_s }
      token
    end

    def generate_order_uuid
      Date.today.to_s.split('-').join()[2..-1] << generate_utoken(8).upcase
    end
  end
end
