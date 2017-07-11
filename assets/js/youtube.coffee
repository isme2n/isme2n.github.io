---
---

$ ->
  $('.youtube').each ->
    width = 560
    height = 420
    $(@).append "<iframe width=\"#{width}\" height=\"#{height}\" src=\"http://www.youtube.com/embed/#{@id}\" frameborder=\"0\" allowfullscreen></iframe>"
