class Todo < ApplicationRecord
    validates_presence_of :title, :description, :current_status, :due_date
    validates_comparison_of :due_date, greater_than: Date.today
    enum current_status: {
    pending: "pending",
    in_progress: "in_progress",
    completed: "completed"
  }
end
