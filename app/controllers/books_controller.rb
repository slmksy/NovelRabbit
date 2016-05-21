class BooksController < ApplicationController
	before_action :find_book, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	def index
		
			@books = Book.all.order("created_at DESC")
		
	end

	def show
		if @book.reviews.blank?
			@average_review = 0
		else
			@average_review = @book.reviews.average(:rating).round(2)
		end
	end

	def new
	  if current_user.id == 1
		@book = current_user.books.build
	end
	end

	def create
		@book = current_user.books.build(book_params)
		

		if @book.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	

	def update
	
		if @book.update(book_params)
			redirect_to book_path(@book)
		
		end
	end

	def destroy
		@book.destroy
		redirect_to root_path
	end

	private

		def book_params
			params.require(:book).permit(:title, :description, :author, :book_img)
		end

		def find_book
			@book = Book.find(params[:id])
		end

end
