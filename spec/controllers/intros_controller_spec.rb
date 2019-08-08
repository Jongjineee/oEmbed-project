require 'rails_helper'

describe IntrosController do
  describe 'GET #index' do
    subject { get :index, params: { video_address: "https://www.flickr.com/photos/bees/2341623661" } }
    context 'URL형식에 맞는 값이 입력 되었을 때' do
      it 'oEmbed를 제공하는 경우 데이터를 보여준다' do
        subject
        
        expect(assigns(:results)).not_to be_nil
      end
    end
  end
  
  describe 'GET #index' do
    subject { get :index, params: { video_address: "https//www.naver.com" } }
    context 'URL형식에 맞는 값이 입력 되었을 때' do
      it 'oEmbed를 제공하지 않는 경우 root로 redirect 된다' do
        subject

        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'GET #index' do
    subject { get :index, params: { video_address: "abcd" } }
    context 'URL형식에 맞지 않는 값이 입력 되었을 때' do
      it '올바른 값이 아니면 root로 redirect 된다' do
        subject
        
        expect(response).to redirect_to root_url
      end
    end
  end
end