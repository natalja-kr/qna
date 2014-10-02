module ControllerMacros
  def user_sign_in
    before do |e|
      unless e.metadata[:skip_sign_in]
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
    end
  end
end