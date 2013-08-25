class CustomerHomeController < ApplicationController
  def index
    authorize!(:index, :customer_home)
  end
end
