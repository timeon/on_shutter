require 'will_paginate/array'

class PrayerRequestsController < ApplicationController
  include PostsController
  
  before_filter :logged_in?, :except => [:index, :show]
  before_filter :ensure_admin_or_owner, :only => [:create, :edit, :update, :destroy]
end
