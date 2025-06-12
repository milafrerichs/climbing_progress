module ApplicationHelper
  def gravatar_url(user, size: 40)
    email_address = user.email.downcase
    hash = Digest::SHA256.hexdigest(email_address)
    params = URI.encode_www_form(s: size)
    "https://www.gravatar.com/avatar/#{hash}?#{params}"
  end
end
