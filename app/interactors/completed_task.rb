class CompletedTask
  include Interactor::Organizer

  organize CreateTracking, SendNotification
end
