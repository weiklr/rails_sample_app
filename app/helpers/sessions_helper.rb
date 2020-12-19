module SessionsHelper
    #Because temporary cookies created using the session method 
    # are automatically encrypted, the code is
    # secure, and there is no way for an attacker 
    #to infer the id from the encrypted version. 
    def log_in(user)
        session[:user_id] = user.id
    end

    def log_out
        reset_session
        @current_user = nil
    end 
    
    def current_user
        if session[:user_id]
            # short hand for short-circuit evaluation, assigns 2nd value if variable is nil or Falsy
            # i.e. @current_user = @current_user || "a value"
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !current_user.nil?
    end
end
