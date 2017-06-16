module UserSideStandardActions
  extend ActiveSupport::Concern

  PAGINATE_PER_PAGE = 30

  private
  def standard_index
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{objects_name}", klass.index)
  end

  def standard_show
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", klass.find(params[:id]))
  end

  def standard_new
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", klass.new)
  end

  def standard_create
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", obj = current_user.send("#{objects_name}").build(permit_params))
    if instance_variable_get(:"@#{object_name}").save
      redirect_to [ :admin, instance_variable_get(:"@#{object_name}") ]
    else
      render :new
    end
  end

  def new_with_sub_questions
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", klass.new)
    SysConst::NUMBER_OF_SUB_QUESTIONS[object_name.to_sym].times do
      sub_question = instance_variable_get(:"@#{object_name}").sub_questions.build
      SysConst::COUNT_OF_OPTIONS[object_name.to_sym].times { sub_question.options.build }
    end
  end

  def create_with_sub_questions
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", obj = current_user.send("#{objects_name}").build(params[object_name.to_sym]))
    question = instance_variable_get(:"@#{object_name}")
    if question.save
      redirect_to instance_variable_get(:"@#{object_name}")
    else
      render :new
    end
  end

  def update_with_sub_questions
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", obj = klass.find(params[:id]))
    question = instance_variable_get(:"@#{object_name}")
    if question.update_attributes(params[object_name.to_sym])
      question.sub_questions_attributes = params[object_name.to_sym][:sub_questions_attributes]
      question.sub_questions.map(&:save)
      redirect_to instance_variable_get(:"@#{object_name}")
    else
      render :edit
    end
  end

  private
  def preparation
    klass = controller_name.classify.constantize
    object_name = ActiveModel::Naming.singular(klass)
    objects_name = ActiveModel::Naming.plural(klass)
    return klass, object_name, objects_name
  end
end
