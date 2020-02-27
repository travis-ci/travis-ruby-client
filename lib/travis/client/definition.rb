module Travis
  module Client
    module Definition
      Action = Struct.new(:resource, :name, :templates)
      Params = Struct.new(:resource, :method, :required, :optional, :body)
      Template = Struct.new(:resource, :method, :required, :optional, :template, :params)
    end
  end
end
