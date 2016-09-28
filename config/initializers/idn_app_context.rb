
class IdnAppContext < IdnSdkRuby::Com::Nbos::Capi::Api::V0::InMemoryApiContext

 def initialize(name = nil, conText = nil)
 	 super(name) if name != nil
 end

 def init()
 end	

 	#CLIENT TOKEN set/get
    def setClientToken(tokenApiModel)
    	super(tokenApiModel)
    end

    def getClientToken
      tokenApiModel = super
      if (tokenApiModel != nil)
        return tokenApiModel
      else
        return nil
      end  
    end

    def setUserToken(moduleName, tokenApiModel)
    	super(moduleName, tokenApiModel)
    end

    def getUserToken(moduleName)
        tokenApiModel = super(moduleName)
        if (tokenApiModel != nil)
          return tokenApiModel
        else
        	return nil    
        end
    end

    def getHost(moduleName)
      host = CONFIG["modules"]["#{moduleName}"]["host"]
      if host != nil
        return host
      else
        return "http://api.qa1.nbos.in"   
      end 
    end

    def setClientCredentials(moduleName)
      map = {}
      #Read client credentials from ENVS
      if moduleName == "app"
        client_key = CONFIG["#{moduleName}"]["client_key"]
        client_secret = CONFIG["#{moduleName}"]["client_secret"]
      else  
        client_key = CONFIG["modules"]["#{moduleName}"]["client_key"]
        client_secret = CONFIG["modules"]["#{moduleName}"]["client_secret"]
      end  
      map["client_id"] = client_key != nil ? client_key :"sample-app-client"
      map["client_secret"] = client_secret != nil ? client_secret :"sample-app-secret"
      super(map)
    end  
end

app_context = IdnAppContext.new("app")
app_context.setClientCredentials("app")
IdnSdkRuby::Com::Nbos::Capi::Api::V0::IdnSDK.init(app_context)