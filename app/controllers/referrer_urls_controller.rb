class ReferrerUrlsController < ApplicationController
  before_filter :ensure_admin

  # GET /referrer_urls
  # GET /referrer_urls.xml
  def index

    if params[:source] == "external"
      @referrer_urls = ReferrerUrl.all(:conditions => "url NOT LIKE '%http://www.onshutters.com%'")
    elsif params[:source] == "internal"
      @referrer_urls = ReferrerUrl.all(:conditions => "url LIKE '%http://www.onshutters.com%'")
    else
      @referrer_urls = ReferrerUrl.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @referrer_urls }
    end
  end

  # DELETE /referrer_urls/1
  # DELETE /referrer_urls/1.xml
  def destroy
    @referrer_url = ReferrerUrl.find(params[:id])
    @referrer_url.destroy

    respond_to do |format|
      format.html { redirect_to(referrer_urls_url) }
      format.xml  { head :ok }
    end
  end
end
