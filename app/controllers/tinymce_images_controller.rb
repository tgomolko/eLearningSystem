class TinymceImagesController < ApplicationController
  def create
    image = TinymceImage.new(tinymce_params)
    image.owner = owner
    if image.save
      render json: { image: { url: image.file.url } }, content_type: "text/html"
    else
      render json: { error: { message: image.errors.full_messages.join(', ') } }
    end
  end

  private

  def tinymce_params
    params.permit(:file)
  end

  def owner
    @owner ||= params[:owner].constantize.find(params[:course_id])
  end
end
