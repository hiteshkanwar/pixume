class LinkedinUserRefusedConstraint
  def self.matches?(request)
    request.query_parameters["oauth_problem"] == "user_refused"
  end
end
