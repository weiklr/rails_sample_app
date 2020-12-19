module SessionsHelper
    #Because temporary cookies created using the session method 
    # are automatically encrypted, the code is
    # secure, and there is no way for an attacker 
    #to infer the id from the encrypted version. 
    def log_in(user)
        session[:user_id] = user.id
        # Guard against session replay attacks.
        # See https://bit.ly/33UvK0w for more.
        session[:session_token] = user.session_token
    end

    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def log_out
        forget(current_user)
        reset_session
        @current_user = nil
    end 

    # Returns the user corresponding to the remember token cookie.
    # Despite appearances, this is not a comparison 
    # (which would use double-equals ==), 
    # but rather is an assignment. If you were to read it in words, 
    # you wouldn’t say “If user id equals session of user id…”, 
    # but rather something like “If session of user id exists 
    # (while setting user id to session of user id)…”
    def current_user
        if (user_id = session[:user_id])
            user = User.find_by(id: user_id)
            # prevent session replay attack by comparing session token is the same as 
            @current_user ||= user if session[:session_token] == user.session_token           
            # @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
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

    # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
end
