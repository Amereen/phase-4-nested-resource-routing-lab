class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  def index
    if params[:user_id] 
    user= User.find(params[:user_id]) 
    render json: user.items
    else
    items = Item.all
    render json: items, include: :user
    
  end
  end

  def show
user = User.find(params[:user_id])
item = user.items.find(params[:id])
render json:item

  end

def create 
  user = User.find(params[:user_id])
  item = user.items.build(item_params)
  if item.save
  render json: item, status: :created
else
  render json: { error: item.errors.full_messages }, status: :unprocessable_entity
end
end








private
def not_found_error
render json: {error:'user is not found'}, status: :not_found
end
def item_params
  params.require(:item).permit(:name, :description, :price) # Add any other attributes here
end
end
