# app/models/animal.rb
class Animal < ApplicationRecord
    belongs_to :herd
  
    after_create_commit do
      broadcast_append_to "dashboard_events",
        target: "events_stream",
        partial: "dashboard/event",
        locals: { event_type: "animal_added", message: "Animal #{self.name} was added to #{self.herd.name} Herd." }
    end
  
    after_update_commit do
      broadcast_append_to "dashboard_events",
        target: "events_stream", 
        partial: "dashboard/event",
        locals: { event_type: "animal_updated", message: "Animal #{self.name} was marked as #{self.status}." }
    end  
  
    private
  
    def broadcast_event(event_type, message)
      broadcast_prepend_to(
        "dashboard_events",
        partial: "dashboard/event",
        target: "events_stream",
        locals: { message: message, event_type: event_type }
      )
    end
  end
  