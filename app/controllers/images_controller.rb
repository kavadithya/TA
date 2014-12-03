class ImagesController < ApplicationController
  require 'json'

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
    read_json_points
  end

  def index
  	@images = Image.all
  end


  private

	def image_params
	  params.require(:image).permit(:name, :avatar)
	end

	def save_cleaned
  	currentLocation = 'public' +  @image.avatar_url.to_s
  	currentLocation.gsub! '/','\\'
		path, slash, imageName  = currentLocation.rpartition("\\")
    newImageURL = path + '\\cleaned\\' + imageName 
    system("echo " + newImageURL)
    cmd = 'java -jar cleaner_64.jar 1 ' + currentLocation
    if system(cmd)
      print "DONE :)"
      @image.cleaned = File.open(newImageURL)
      @image.save!
    end
	end		

  def read_json_points
    currentLocation = 'public' + @image.avatar_url.to_s
    currentLocation.gsub! '/','\\'
    path, slash, imageName  = currentLocation.rpartition(".jpg")
    jsonFileLocation = path + ".json"
    @data = File.read(jsonFileLocation)
    print @data

  end

end
