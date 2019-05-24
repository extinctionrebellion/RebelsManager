class Components::MenuPresenter < PresenterBase
  attr_reader :active_primary, :active_secondary, :active_tertiary,
    :primary_secondary_items, :object, :controller_name, :action_name,
    :view_context

  def initialize(
    view_context: nil,
    active_primary: nil,
    active_secondary: nil,
    active_tertiary: nil,
    object: nil,
    controller_name: nil,
    action_name: nil
  )
    @view_context         = view_context

    @active_primary       = active_primary
    @active_secondary     = active_secondary
    @active_tertiary      = active_tertiary

    @object               = object
    @controller_name      = controller_name
    @action_name          = action_name

    @primary_left_items   = primary_left_items
    @primary_right_items  = primary_right_items
    @secondary_items      = secondary_items
    @tertiary_items       = tertiary_items
    @actions_items        = actions_items
  end

  def has_actions_items?
    actions_items&.any? and
    actions_items.collect { |i| i.fetch(:condition, true) }.include?(true)
  end

  def render_primary_left_menu(options = {})
    render_menu_items(@primary_left_items, 'primary', options)
  end

  def render_primary_right_menu(options = {})
    render_menu_items(@primary_right_items, 'primary', options)
  end

  def render_secondary_menu(options = {})
    render_menu_items(@secondary_items, 'secondary', options)
  end

  def render_tertiary_menu(options = {})
    render_menu_items(@tertiary_items, 'tertiary', options)
  end

  def render_actions_menu(options = {})
    render_menu_items(@actions_items, 'actions', options)
  end

  def render_menu_items(menu_items, level, options = {})
    if menu_items.present?
      ul_options = { class: ['menu', options[:class]] }
      if options[:dropdown]
        ul_options[:class] << 'dropdown'
        ul_options[:"data-dropdown-menu"] = ''
      end
      content_tag(:ul, ul_options) do
        menu_items
        .each_with_index
        .inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
          if item.fetch(:condition, true)
            buffer << render_menu_item(item, level, index)
          end
          buffer
        end
      end
    end
  end

  def render_menu_item(menu_item, level, index)
    content_tag(:li, class: menu_item_css(menu_item, index)) do
      buffer = ActiveSupport::SafeBuffer.new
      buffer << render_menu_item_link(menu_item)
      if menu_item[:children]
        buffer << render_menu_items(menu_item[:children], level)
      end
      if menu_item.fetch(:active, false) and level == 'primary'
        buffer << render_menu_items(
          @secondary_items,
          'secondary',
          class: 'nested vertical'
        )
      end
      buffer
    end
  end

  def render_menu_item_link(menu_item)
    link_to(
      raw(menu_item[:body]),
      menu_item[:url],
      menu_item[:html_options],
    )
  end

  def menu_item_css(menu_item, _index)
    css = []

    css << 'active' if menu_item[:active]
    css << menu_item[:class]

    css.reject(&:blank?).presence
  end

  def primary_left_items
    [
      {
        body: ::ApplicationController.helpers.image_tag(
          asset_pack_path('media/images/symbol.svg'),
          alt: 'XR Namur'
        ),
        url: manager_root_path,
        class: 'menu-text show-for-large'
      },
      {
        body: 'Rebels',
        url: manager_rebels_path,
        active: @active_primary == 'rebels'
      },
      {
        body: 'Working Groups',
        url: manager_working_groups_path,
        active: @active_primary == 'working_groups'
      },
      {
        body: 'Local Groups',
        url: manager_local_groups_path,
        active: @active_primary == 'local_groups'
      }
    ]
  end

  def primary_right_items
    [
      {
        body: 'Log out',
        url: destroy_user_session_path,
        html_options: { method: :delete }
      }
    ]
  end

  def secondary_items
    case @active_primary
    when 'foo'
      foo_menu_items
    end
  end

  def tertiary_items
    case @active_secondary
    when 'foo'
      foo_menu_items
    end
  end

  def actions_items
    menu_items_method_name = "#{controller_name}_#{action_name}_menu_items"
    if self.respond_to?(menu_items_method_name.to_sym, true)
      self.method(menu_items_method_name.to_sym).call
    else
      []
    end
  end

  private

  def foo_menu_items
    []
  end
end
