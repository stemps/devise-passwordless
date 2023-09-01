require "rails_helper"
require "yaml"
require "system/shared/shared_sign_in_spec"

RSpec.describe "PasswordlessUser sign in", :type => :system do
  let(:email) { "foo@example.com" }
  before do
    driven_by(:rack_test)
  end

  context "shared examples" do
    let(:sign_in_path) { "/passwordless_users/sign_in" }
    let(:user) { PasswordlessUser.create(email: email) }
    let(:css_class) { "passwordless_user" }
    let(:yaml_global) { YAML.load(
      <<~DEVISE_I18N
      devise:
        passwordless:
          magic_link_sent: "Custom magic link sent message"
        mailer:
          magic_link:
            subject: "Custom magic link message"
      DEVISE_I18N
    )}
    let(:yaml_specific) { YAML.load(
      <<~DEVISE_I18N
      devise:
        passwordless:
          passwordless_user:
            magic_link_sent: "Custom magic link sent message"
          passwordless_confirmable_user:
            magic_link_sent: "YYY"
          magic_link_sent: "XXX"
        mailer:
          magic_link:
            passwordless_user_subject: "Custom magic link message"
            passwordless_confirmable_user_subject: "YYY"
            subject: "XXX"
      DEVISE_I18N
    )}

    include_examples "resource sign-in shared examples"
  end
end
