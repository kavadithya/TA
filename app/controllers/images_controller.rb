class ImagesController < ApplicationController
  
  def new
  	@image = Image.new
  end

  def create
  	@image = Image.new(image_params)

  	if @image.save
  		# yo yo
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

end
