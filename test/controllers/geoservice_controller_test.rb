require 'test_helper'

class GeoserviceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get geoservice_index_url
    assert_response :success
  end

end
