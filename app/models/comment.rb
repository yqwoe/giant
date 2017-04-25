class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  class << self
    def average_env_star
      self.average :env_star
    end

    def average_service_star
      self.average :service_star
    end

    def average_clean_star
      self.average :clean_star
    end
  end

  def sum_star
    (env_star + service_star + clean_star) / 3
  end
end
