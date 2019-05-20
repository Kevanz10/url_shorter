class ShortUrlsController < ApplicationController

	def index
		@short_urls = ShortUrl.most_visited(params[:page], 10)
	end

	def new
		@short_url = ShortUrl.new
	end

	def create
		@short_url = ShortUrl.new(short_urls_params)
		respond_to do |format|
      if @short_url.save
        format.html { redirect_to short_urls_path, notice: 'Short url created' }
      else
      	flash[:error] = @short_url.errors.full_messages
				format.html { render :new}
      end
    end
	end

	def redirection
		short_url = ShortUrl.find_by(shorted_url: params[:short_url_id])
		if short_url.present?
			short_url.increase_visits
			redirect_to short_url.url
		else
			redirect_to url_not_found_path
		end
	end

	def short_urls_params
		params.require(:short_url).permit(:url)
	end
end
