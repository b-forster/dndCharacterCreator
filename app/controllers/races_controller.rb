get "/races/:race_name" do
  if request.xhr?
    content_type :json
    Race.find_by(name: params[:race_name]).to_json
  end
end