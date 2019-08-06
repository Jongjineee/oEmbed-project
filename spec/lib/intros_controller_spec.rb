require 'rails_helper'

describe IntrosController do
  describe 'GET #index' do
    context 'URL형식에 맞는 값이 입력 되었을 때' do
      it 'oEmbed를 제공하는 경우 데이터를 보여준다' do

        result = FetchOembedData.call('https://giphy.com/gifs/3o7TKSha51ATTx9KzC')
        expect(result['type']).to eq 'video'
        expect(result['version']).to eq '1.0'
        expect(result['title']).to eq 'Test'
      end

      it 'oEmbed를 제공하지 않는 경우 에러가 발생한다' do

      end
    end

    context 'URL형식에 맞지 않는 값이 입력 되었을 때' do
      it '올바른 값이 아니면 에러가 발생한다' do

      end
    end
  end
end