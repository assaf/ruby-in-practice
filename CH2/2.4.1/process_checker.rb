class ProcessChecker
  def initialize
    @ps_output = `ps -A`
  end
  
  def rails_server?
    @ps_output =~ /ruby script\/server/
  end

  # Other process-checking methods…
end
