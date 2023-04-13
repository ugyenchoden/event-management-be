# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateUser do
  let_it_be(:profile_a) do
    { firstname: 'Jeon', lastname: 'Jungkook', phone: '974122345' }
  end

  let_it_be(:admin) { create(:user, :admin, profile_attributes: profile_a) }

  describe '.resolve' do
    context 'with valid params' do
      let!(:params) do
        {
          id: admin.id,
          profile_id: admin.profile.id,
          firstname: 'John',
          lastname: 'Legend'
        }
      end

      it 'updates the user' do
        response, errors = formatted_response(query(params), current_user: admin, key: :updateUser)
        expect(errors).to be_nil

        user = response.user
        expect(user.profile).to have_attributes(
          firstname: 'John',
          lastname: 'Legend'
        )
      end
    end

    context 'with invalid params' do
      let!(:params) do
        {
          id: admin.id,
          profile_id: admin.profile.id,
          firstname: '',
          lastname: ''
        }
      end

      it 'responds with error' do
        response, errors = formatted_response(query(params), current_user: admin, key: :updateUser)
        expect(response.user).to be_nil

        expect(errors).to contain_exactly([
          "Profile firstname #{t('errors.messages.blank')}",
          "Profile lastname #{t('errors.messages.blank')}"
        ].to_sentence)
      end
    end
  end

  def query(args = {})
    profile = <<~PROFILE
      profile: {
        id: "#{args[:profile_id]}"
        firstname: "#{args[:firstname]}"
        lastname: "#{args[:lastname]}"
      }
    PROFILE

    <<~GQL
      mutation {
        updateUser(
          input: {
            attributes: {
              id: "#{args[:id]}"
              #{profile if args[:profile_id]}
            }
          }
        )
        { user { id email profile { firstname lastname } } }
      }
    GQL
  end
end
