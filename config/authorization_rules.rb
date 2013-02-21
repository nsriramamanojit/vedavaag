authorization do

  role :sa do
    has_permission_on [:users,:roles,:states,:districts], :to=>[:index,:new,:create,:show,:export,:profile,:profile_update,:update_profile,:change_password,:password_change]
    has_permission_on [:accounts], :to=>[:index,:new,:create,:show,:edit,:update,:export,:upload,:csv_import,:approve,:destroy]
    has_permission_on [:transactions], :to=>[:index,:new,:create,:show,:edit,:approve,:approve_pay]
  end

  role :admin do
    has_permission_on [:users,:roles,:states,:districts], :to=>[:index,:new,:create,:show,:export,:profile,:profile_update,:update_profile,:change_password,:password_change]
    has_permission_on [:accounts], :to=>[:index,:new,:create,:show,:edit,:update,:export,:upload,:csv_import,:approve,:destroy]
    has_permission_on [:transactions], :to=>[:index,:new,:create,:show,:edit,:approve,:approve_pay]
  end

  role :manager do
    has_permission_on [:users,:roles,:states,:districts], :to=>[:index,:new,:create,:show,:export,:profile,:profile_update,:update_profile,:change_password,:password_change]
    has_permission_on [:accounts], :to=>[:index,:new,:create,:show,:edit,:update,:export,:upload,:csv_import,:approve,:destroy]
    has_permission_on [:transactions], :to=>[:index,:new,:create,:show,:edit,:approve,:approve_pay]
  end

  role :employee do
    has_permission_on [:transactions], :to=>[:index,:new,:create,:show,:edit,:approve,:approve_pay]
    has_permission_on [:users], :to=>[:profile,:profile_update,:update_profile,:change_password,:password_change]

  end

end