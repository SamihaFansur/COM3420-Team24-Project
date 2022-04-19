require 'rails_helper'

describe ErrorsController, type: :controller do

    describe "GET 'error_404'" do
        it "returns http status 404" do
          get 'error_404'
          response.response_code.should == 404
        end
      end
    
      describe "GET 'error_500'" do
        it "returns http status 500" do
          get 'error_500'
          response.response_code.should == 500
        end
      end

      describe "GET 'http success'" do
        it "returns http success" do
            visit root_path
            expect(response).to have_http_status(:success)
        end
    end

    it 'response with 404 if page not found' do
        get :show, { controller: 'pages', id: 'not_existing_page_321' }
        expect(response.status).to eq(404)
      end
    
      it 'renders an error-message if page not found and shows index' do
        visit root_path
        within '.alert-error' do
          page.should have_content("Page page_not_found doesn't exist")
        end
      end
    end