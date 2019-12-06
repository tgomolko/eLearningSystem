module UserPageHelper
  def submit_page(page, last_page)
    if page == last_page
      submit_tag("Submit LastPage", class: 'button is-medium is-info is-rounded')
    else
      submit_tag("Next page", class: 'button is-medium is-info is-rounded')
    end
  end
end
