# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::UsersResolver do
  let_it_be(:profile_a) do
    { firstname: 'Jeon', lastname: 'Jungkook', phone: '9751712345' }
  end

  let_it_be(:profile_b) do
    { firstname: 'Jeff', lastname: 'Satur', phone: '9751712345' }
  end

  let_it_be(:admin) { create(:user, :admin, profile_attributes: profile_a) }
  let_it_be(:user) { create(:user, :user, profile_attributes: profile_b) }

  describe '.resolve' do
    context 'without filters' do
      it 'returns all users' do
        users, errors = paginated_collection(:users, query, current_user: admin)
        expect(errors).to be_nil
        expect(users.pluck(:id)).to eq([admin.id, user.id])
      end
    end

    context 'with role filters' do
      it 'returns users matching the given roles' do
        users, errors = paginated_collection(:users, query(role_ids: role_ids(['user'])), current_user: user)
        expect(errors).to be_nil
        expect(users.pluck(:id)).to contain_exactly(user.id)
      end
    end

    context 'with search resolvers' do
      it 'returns users matching query' do
        users, errors = paginated_collection(:users, query(query: 'jungkook'), current_user: user)
        expect(errors).to be_nil
        expect(users.pluck(:id)).to contain_exactly(admin.id)
      end
    end
  end

  def query(args = {})
    connection_query("users#{query_string(args)}", 'id email name roleName')
  end
end
