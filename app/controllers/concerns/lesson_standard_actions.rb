module LessonStandardActions
  extend ActiveSupport::Concern

  PAGINATE_PER_PAGE = 30

  private
  def lesson_standard_index
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{objects_name}", Examination.send("#{objects_name}"))
  end

  def lesson_standard_show
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", Examination.find(params[:id]))
  end

  def lesson_standard_new
    klass, object_name, objects_name = preparation
    @questions = object_name.gsub('_lesson', "").classify.constantize.all
    instance_variable_set(:"@#{object_name}", Examination.new)
  end

  def lesson_standard_create
    klass, object_name, objects_name = preparation
    params[:examination][:question_ids] = params[:question_ids] if params[:examination][:question_ids].nil?
    instance_variable_set(:"@#{object_name}", obj = current_user.examinations.build(permit_params))
    @questions = object_name.gsub('_lesson', "").classify.constantize.all
    if instance_variable_get(:"@#{object_name}").save
      redirect_to action: :index
    else
      render :new
    end
  end

  def lesson_standard_edit
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", Examination.find(params[:id]))
    @questions = object_name.gsub('_lesson', "").classify.constantize.all
  end

  def lesson_standard_update
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", obj = Examination.find(params[:id]))
    @questions = object_name.gsub('_lesson', "").classify.constantize.all
    if instance_variable_get(:"@#{object_name}").update_attributes(permit_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def lesson_standard_destroy
    klass, object_name, objects_name = preparation
    instance_variable_set(:"@#{object_name}", Examination.find(params[:id]))
    if instance_variable_get(:"@#{object_name}").destroy
      redirect_to action: :index
    else
      redirect_to :back
    end
  end

  private
  def preparation
    klass = Examination
    object_name = controller_name.singularize
    objects_name = controller_name
    return klass, object_name, objects_name
  end
end
