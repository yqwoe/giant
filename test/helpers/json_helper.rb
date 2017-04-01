require 'test_helper'

module ActionDispatch
  class IntegrationTest
    def prase_json
      JSON.parse(resonse.body)
    end
  end
end
