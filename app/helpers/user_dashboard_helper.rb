module UserDashboardHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { sort: column, direction: direction }, { class: "css_class" }
  end

  def paginate(entities)
    content_tag :div, class: "section" do
      content_tag :div, class: "container" do
       content_tag :div, will_paginate(entities, renderer: BulmaPagination::Rails), class: "columns is-centered"
      end
    end
  end

  def search_form(path)
    form_tag path, method: :get, class: "search-form" do
      (text_field_tag :q, params[:q], class: "string required input search") +
      (submit_tag "Search", class: "button is-info is-rounded")
    end
  end
end
