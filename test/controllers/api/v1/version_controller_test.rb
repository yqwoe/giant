require 'test_helper'

class Api::V1::VersionsControllerTest < ActionDispatch::IntegrationTest
   test 'android and shop version' do
     get api_v1_version_url, params: {
       os: 'andriod',
       kind: 'shop'
     }

     assert_response :success
     assert_match(/shop\.apk/, response.body)
   end

   test 'ios and shop version' do
     get api_v1_version_url, params: {
       os: 'ios',
       kind: 'shop'
     }

     assert_response :success
     assert_match(/[^apk]/, response.body)
   end

   test 'android and car_onwer version' do
     get api_v1_version_url, params: {
       os: 'android',
       kind: 'car_owner'
     }

     assert_response :success
     assert_match(/[^shop].*apk/, response.body)
   end

   test 'ios and car_onwer version' do
     get api_v1_version_url, params: {
       os: 'ios',
       kind: 'car_owner'
     }

     assert_response :success
     assert_match(/[^apk]/, response.body)
   end
end
