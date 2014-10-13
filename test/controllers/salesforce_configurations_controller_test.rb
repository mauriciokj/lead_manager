require 'test_helper'

class SalesforceConfigurationsControllerTest < ActionController::TestCase
  setup do
    @salesforce_configuration = salesforce_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salesforce_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salesforce_configuration" do
    assert_difference('SalesforceConfiguration.count') do
      post :create, salesforce_configuration: { client_id: @salesforce_configuration.client_id, client_secret: @salesforce_configuration.client_secret, password: @salesforce_configuration.password, security_token: @salesforce_configuration.security_token, username: @salesforce_configuration.username }
    end

    assert_redirected_to salesforce_configuration_path(assigns(:salesforce_configuration))
  end

  test "should show salesforce_configuration" do
    get :show, id: @salesforce_configuration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @salesforce_configuration
    assert_response :success
  end

  test "should update salesforce_configuration" do
    patch :update, id: @salesforce_configuration, salesforce_configuration: { client_id: @salesforce_configuration.client_id, client_secret: @salesforce_configuration.client_secret, password: @salesforce_configuration.password, security_token: @salesforce_configuration.security_token, username: @salesforce_configuration.username }
    assert_redirected_to salesforce_configuration_path(assigns(:salesforce_configuration))
  end

  test "should destroy salesforce_configuration" do
    assert_difference('SalesforceConfiguration.count', -1) do
      delete :destroy, id: @salesforce_configuration
    end

    assert_redirected_to salesforce_configurations_path
  end
end
