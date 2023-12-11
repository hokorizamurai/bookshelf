class BooksController < ApplicationController
  def search
    api_key = 'google_books_API_KEY'
    query = params[:query]

    response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{api_key}")

    @books = JSON.parse(response.body)['items']
  end
end
