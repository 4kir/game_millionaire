require 'rails_helper'

RSpec.feature 'USER viewing alien game', type: :feature do
  let(:timur) { FactoryBot.create :user, name: 'Тимур', balance: 1000 }
  let(:sergey) { FactoryBot.create :user, name: 'Сергей', balance: 5000 }
  let!(:game) do [
      FactoryBot.create(:game, id: 15, created_at: Time.parse('2016.10.09, 13:00'), finished_at: Time.parse('2016.10.09, 13:30'), is_failed: true, current_level: 15, prize: 1000, user: sergey),
      FactoryBot.create(:game, id: 19, created_at: Time.parse('2016.10.09, 18:00'), current_level: 7, prize: 2000, user: sergey) 
    ]
  end

  before(:each) do
    login_as timur
  end

  scenario 'successfully' do
    visit '/'
    click_link 'Сергей'

    expect(page).not_to have_content 'Сменить имя и пароль'
    expect(page).to have_content 'Сергей'
    expect(page).to have_content 'в процессе'
    expect(page).to have_content 'проигрыш'
    expect(page).to have_content '1 000 ₽'
    expect(page).to have_content '2 000 ₽'
    expect(page).to have_content '09 окт., 13:00'
    expect(page).to have_content '09 окт., 18:00'
  end
end