module Admin::SessionsHelper
  def brute_force_counter(remote_ip: request.remote_ip)
    bf = BruteForce.where "remote_ip=? and created_at>=?", remote_ip, DateTime.now - 10.minutes
    bf.empty? ? 0 : bf.first.counter
  end

  def brute_force_add(remote_ip: request.remote_ip, count: 1)
    bf = BruteForce.where("remote_ip=? and created_at>=?", remote_ip, DateTime.now - 10.minutes)
          .first_or_create(remote_ip: remote_ip)
    bf.increment! :counter
    bf.counter.to_i
  end
end
