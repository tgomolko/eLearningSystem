module EsHelper
  def as_indexed_json(params={})
    {
      title: title,
      description: description,
      created_at: created_at,
      aasm_state: aasm_state,
      access_state: access_state
    }
  end

  def preview
    if description.size > 25
      description[0, 25] + '...'
    else
      description
    end
  end
end
