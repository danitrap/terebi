class UpdateEpisodes
  def perform
    Episode.update_episodes
  end
  
  def success(job)
    UpdateEpisodes.schedule_job(job)
  end
  
  def self.time_to_recur
    DateTime.now + 1.hour
  end
  
  def self.queue_name
    "UpdateEpisodes"
  end
  
  def self.schedule_job(job=nil)
    if job_exists?(job)
      puts "#{queue_name} job is already scheduled for #{time_to_recur}."
    else
      Delayed::Job.enqueue new, :run_at => time_to_recur, :queue=> queue_name  
      puts "A new #{queue_name} job has been scheduled for #{time_to_recur}."
    end
  end
  
  # If you want make sure a job recurs once per cycle, 
  # important if you have multiple DJ workers or App servers.
  def self.job_exists?(job=nil)
    conditions = ['queue = ? AND failed_at IS NULL', queue_name]
    unless job.blank?
      conditions[0] << " AND id != ?"
      conditions << job.id
    end
    Delayed::Job.exists?(conditions)
  end 
end