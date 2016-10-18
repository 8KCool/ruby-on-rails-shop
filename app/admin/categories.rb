ActiveAdmin.register Category do
  permit_params :name, :hided

  ### Disable some actions
  actions :all, except: [:show]

  ### Index as table
  index download_links: false do
    selectable_column
    column :name
    column :hided
    column :created_at
    column :updated_at
    actions
  end

end
