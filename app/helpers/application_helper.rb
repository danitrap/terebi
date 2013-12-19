module ApplicationHelper

def full_title(title)
  if title.present?
    title
  else
    "Terebi"
  end
end

end
