# This module is expanded in order to make it easier to use polymorphic
# routes with nested resources in the admin namespace
module ActionDispatch::Routing::UrlFor
  def resource_hierarchy_for(resource)
    resolve = resolve_for(resource)

    if resolve
      if resolve.last.is_a?(Hash)
        [resolve.first, *resolve.last.values]
      else
        resolve
      end
    else
      resource
    end
  end

  def polymorphic_index(resource, options = {})
    resolve = resolve_for(resource)

    if resolve
      resolve_without_resource = resolve[0..-2]

      if resolve_without_resource.last.is_a?(Symbol)
        resolve_without_resource[-1] = resolve_without_resource.last.to_s.pluralize.to_sym
        polymorphic_path(resolve_without_resource, options)
      else
        polymorphic_path([*resolve_without_resource, resource.class])
      end
    elsif resource.is_a?(String)
      polymorphic_path(resource.constantize, options)
    else
      polymorphic_path(resource.class, options)
    end
  end

  def admin_polymorphic_path(resource, options = {})
    if %w[Budget::Group Budget::Heading Poll::Booth Poll::BoothAssignment Poll::Officer
          Poll::Question Poll::Question::Answer::Video Poll::Shift].include?(resource.class.name)
      resolve = resolve_for(resource)
      resolve_options = resolve.pop

      polymorphic_path([:admin, *resolve], options.merge(resolve_options))
    else
      polymorphic_path([:admin, *resource_hierarchy_for(resource)], options)
    end
  end

  private

    def resolve_for(resource)
      polymorphic_mapping(resource)&.send(:eval_block, self, resource, {})
    end
end
