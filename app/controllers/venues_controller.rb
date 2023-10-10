class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.first

    render({ :template => "venue_templates/details" })
  end

  def create
    # Parameters: {"query_address"=>"200 s wacker", "query_name"=>"dpi", "query_neighborhood"=>"downtown"}

    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/#{venue.id}")
  end
  
  def update
   #  Parameters: {"query_address"=>"1417 Stan Trail, Lake Sandy, NY 32624", "query_name"=>"Red Brasserie", "query_neighborhood"=>"Paradise Crossingg", "the_id"=>"1"}
    the_id = params.fetch("the_id")
    venue = Venue.where({ :id => the_id }).at(0)
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save
    
    redirect_to("/venues/#{venue.id}")
  end

  def destroy
    #  Parameters: {"id_to_delete"=>"1"}
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.first
    venue.destroy
    
    redirect_to("/venues")
  end

end
