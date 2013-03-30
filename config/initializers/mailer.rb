ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "vedavaag.com",
    :user_name            => "chaitanya@vedavaag.com",
    :password             => "vedavaag14779@#",
    :authentication       => :plain,
    :enable_starttls_auto => false

}

ActionMailer::Base.delivery_method = :smtp