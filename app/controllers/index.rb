get '/' do
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  erb :new_event
end

post '/events' do
  new_event = Event.create(params)
  if new_event.valid?
    redirect "/events/#{new_event.id}/show"
  else
    @error_messages = new_event.errors.messages
    @field_values = params
    erb :new_event
  end
end
