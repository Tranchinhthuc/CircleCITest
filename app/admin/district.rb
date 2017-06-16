ActiveAdmin.register District do
  permit_params :city_id, :name, :description

  form do |f|
      f.semantic_errors
      f.inputs do
        f.input :name
        f.input :city_id, as: :select, collection: City.all.map{|c| [c.name, c.id]}, :input_html => { :value => current_admin_user.id}, include_blank: false
        f.input :description, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
      end
      f.actions
    end
end
