function Header(el)
  if el.tag == "Header" then
    local custom = el.attr.attributes["header-title"]
    if custom then
      -- Inject a command to update the header for this section
      local latex = "\\renewcommand{\\myheader}{" .. pandoc.utils.stringify(custom) .. "}"
      return {pandoc.RawInline("latex", latex), el}
    end
  end
  return el
end
