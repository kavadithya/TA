class ImagesController < ApplicationController
  
  def new
  	@image = Image.new
  end

  def create
  	@image = Image.new(image_params)

  	if @image.save
  		# yo yo
  		save_cleaned
  		redirect_to @image
  	else
  		render 'new'
  	end
  	
  end

  def show
  	@image = Image.find(params[:id])
  end

  def index
  	@images = Image.all
  end


  private

	def image_params
	  params.require(:image).permit(:name, :avatar)
	end

	def save_cleaned
	  	currentLocation = 'F:\TA\public' + @image.avatar_url.to_s
	  	currentLocation.gsub! '/','\\'
		splitUp  = currentLocation.split('.')
		newImageURL = splitUp[0] + '-cleaned.' + splitUp[1] 
	  	cmd = 'copy ' + currentLocation + ' ' + newImageURL
	  	if system(cmd)
	  		@image.update(cleaned_image: newImageURL)
	  	end
	end		

end
