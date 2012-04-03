authorization do

  role :admin do
    has_permission_on [:users,:roles,:states,:districts], :to=>[:index,:new,:create,:show,:export,:profile,:profile_update,:update_profile,:change_password,:password_change]
    has_permission_on [:accounts], :to=>[:index,:new,:create,:show,:edit,:update,:export,:upload,:csv_import,:approve,:destroy]
  end

end