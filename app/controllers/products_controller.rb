# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  def index
    @products = Product.all
    render json: @products
  end

  def find_by_slug
    slug = params[:slug]

    @product = Product.find_by_slug(slug)

    if @product.present?
      render json: @product
    else
      error_message(@product, :not_found)
    end
  end


  def active_products
    @products = Product.active_products
    render json: @products
  end

  def create
    @product = Product.new(product_params)
    if @product.save!
      render json: @product
    else
      error_message(@product, :unprocessable_entity)
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      error_message(@product, :unprocessable_entity)
    end
  end

  def show
    render json: @product
  end

  def destroy; end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :slug, :active)
  end

  def error_message(product, status_code)
    render json: product.errors.full_messages.to_sentence, status: status_code
  end
end
