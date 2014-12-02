class Interview < Struct.new(:_id, :title, :slug)

  include Entities::Extensions::Api

end
