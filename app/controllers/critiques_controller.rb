class CritiquesController < ApplicationController
  include ResponsesController
    
  before_filter :ensure_admin_or_owner, :only => [:create, :edit, :update, :destroy]
end
