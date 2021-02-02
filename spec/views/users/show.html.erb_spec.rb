require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:game) { FactoryBot.build_stubbed(:game, id: 15, created_at: Time.now, current_level: 10, prize: 1000) }
  let(:user) { FactoryBot.create(:user, name: 'Тимур', balance: 1000) }

  context 'when user logged in' do
    before (:each) do
      assign(:game, game)
      assign(:user, user)

      sign_in user

      render
    end

    it 'return game user name' do
      expect(rendered).to match('Тимур')
    end

    it 'check profile editing button is shown' do
      expect(rendered).to match('Сменить имя и пароль')
    end

    it 'check game partial rendering' do
      render partial: 'game', object: game
    end
  end

  context 'when user logged out' do
    before do
      assign(:user, user)
      assign(:games, game)

      render
    end

    it 'return game user name' do
      expect(rendered).to match('Тимур')
    end

    it 'check profile editing button is hidden' do
      expect(rendered).not_to match('Сменить имя и пароль')
    end

    it 'check game partial rendering' do
      render partial: 'game', object: game
    end
  end
end
