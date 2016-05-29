require "rails_helper"

RSpec.feature "Editing an Article" do
  before do
    @article = Article.create(title: "First Article", body: "body of first content")
  end

  scenario "A user update and article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated article"
    fill_in "Body", with: "Update body of article"
    click_button "Update Article"

    expect(page).to have_content("Article has been update")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "A user fail to update an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: "Update body of article"
    click_button "Update Article"

    expect(page).to have_content("Article has not been update")
    expect(page.current_path).to eq(article_path(@article))    
  end
end