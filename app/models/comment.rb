class Comment < ApplicationRecord
  # ASSOCIATIONS
  # -----------------

  belongs_to :commentable, polymorphic: true
end
