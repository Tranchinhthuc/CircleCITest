module ApplicationHelper
  def link_to_remove_fields(name, builder)
    builder.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields label, f, assoc
    new_obj = f.object.class.reflect_on_association(assoc).klass.new
    4.times { new_obj.options.build }
    fields = f.fields_for assoc, new_obj, child_index: "new_#{assoc}" do |builder|
      render "#{assoc.to_s.singularize}_fields", f: builder
    end
    link_to label, "#", onclick: "add_fields(this, \"#{assoc}\",
      \"#{escape_javascript(fields)}\")", remote: true
  end

  def link_to_function name, function, html_options={}
    onclick = "#{"#{html_options[:onclick]}; " if
      html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || '#'
    content_tag :a, name, html_options.merge(href: href, onclick: onclick)
  end

  def singulize_model_name plural_model_name
    ActiveModel::Naming.singular(plural_model_name.classify.constantize)
  end

  def question_index question, from_index
    count_of_sub_questions = question.sub_questions.count
    label = ""
    if count_of_sub_questions <= 2
      label
    else
      count_of_sub_questions.times do |i|
        label += " #{from_index + i}" + (i == (count_of_sub_questions - 1) ? "" : " - ")
      end
    end
    label
  end

  def second_to_time s
    return "00:00:00" if s <= 0
    hours = (s / 3600).floor
    minutes = (s / 60).floor - hours * 60
    seconds = s.floor % 60
    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end
end
