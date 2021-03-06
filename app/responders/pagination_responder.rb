module PaginationResponder
  # Receives a relation and sets the pagination scope in the collection
  # instance variable. For example, in PostsController it would
  # set the @posts variable with Post.all.paginate(params[:page]).
  def to_html
    if get? && resource.is_a?(ActiveRecord::Relation)
      paginated = resource.page(controller.params[:page])
      controller.instance_variable_set("@#{controller.controller_name}", paginated)
    end
    super
  end
end
