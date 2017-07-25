ActiveAdmin.register Office do
  permit_params :user_id, :name, :cover_picture, :description, bank_ids: [], district_ids: [], service_ids: []

  index do
    selectable_column
    column :name
    column :cover_picture do |o|
      image_tag(o.cover_picture.url(:thumb)) if o.cover_picture.present?
    end
    column :user do |o|
      o.user.full_name
    end

    column :description do |o|
      o.description.html_safe
    end
    column :banks do |office|
      office.banks.map(&:name).join(", ")
    end

    column :districts do |office|
      office.districts.map(&:name).join(", ")
    end

    column :services do |office|
      office.services.map(&:name).join(", ")
    end
    actions
    #   item "Preview", admin_preview_post_path(post), class: "member_link"
    # end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :cover_picture
      f.input :bank_ids, as: :check_boxes, collection: Bank.all.map{|b| [b.name, b.id]}, label: "Banks"
      f.input :district_ids, as: :check_boxes, collection: District.all.map{|d| [d.name, d.id]}, label: "Districts"
      f.input :service_ids, as: :check_boxes, collection: Service.all.map{|s| [s.name, s.id]}, label: "Services"
      f.input :description, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
    end
    f.actions
  end

end
