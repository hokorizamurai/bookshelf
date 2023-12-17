class BooksController < ApplicationController
  include HTTParty

  def index
  
  end

  
  def search
    @query = params[:query]

    if @query.present?
      @response =fetch_books(@query)
      @books = parse_response(@response)
    else
      flash.now[:alert] = 'Enter a search query.'
    end
  end

    

  private

  def fetch_books(query)
    # Google Books APIにリクエスト送信
    url = "https://www.googleapis.com/books/v1/volumes?q=#{URI.encode(query)}"
    response = self.class.get(url)
    response.parsed_response
  end

  def parse_response(response)
    # 必要な情報を抽出して返す
    response['items'].map do |item|
      {
        title: item['volumeInfo']['title'],
        author: item['volumeInfo']['authors'].join(','),
        image_url: item['volumeInfo']['imageLinks']&.dig('thumbnail')
      }
    end
  end
end
