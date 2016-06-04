require "rails_helper"

RSpec.feature "Showing an Article" do
  before do 
    @john = User.create(email: "john@example.com", password: "password")
    @bob = User.create(email: "bob@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Body of first article", user: @john)
  end

  scenario "A non-signed in user does not see Editor and Delete links" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A non-owner singed in can not see both links" do
    login_as(@bob)

    visit "/"

    click_link @article.title

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A signed in owner see both link" do
    login_as(@john)

    visit "/"

    click_link @article.title

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "Display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end