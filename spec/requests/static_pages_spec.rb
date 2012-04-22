
require 'spec_helper'

describe 'Static Pages' do

  let(:base_title) { 'rails tutorial' }

  describe 'Home page' do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      page.should have_selector('h1',
                                :text => 'Sample App')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title',
                                :text => "#{base_title}")
    end

    it "should not have the custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title',
                                    :text => 'home')
    end
  end

  describe 'Help page' do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1',
                                :text => 'Help')
    end

    it "should have the right title" do
      visit '/static_pages/help' 
      page.should have_selector('title',
                                  :text => "#{base_title} | help")
      end
  end

  describe 'About page' do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1',
                                :text => 'About Us')
    end

    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title',
                                :text => "#{base_title} | about us")
    end
  end
end
