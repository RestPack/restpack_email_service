module Email
  class Tasks
    def self.load_tasks
      load "restpack_email_service/tasks/db.rake"
    end
  end
end
