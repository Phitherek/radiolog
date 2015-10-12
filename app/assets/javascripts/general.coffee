# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

fire_engines = ->
    utc_date_input = $("input#utc_date")
    utc_time_input = $("input#utc_time")
    if $("input#auto_utc:checked").length > 0
         utc_date_input.prop("disabled", true)
         utc_time_input.prop("disabled", true)
         auto_utc_update()
    else
        utc_date_input.prop("disabled", false)
        utc_time_input.prop("disabled", false)
    $("input#auto_utc").change(->
        utc_date_input = $("input#utc_date")
        utc_time_input = $("input#utc_time")
        if $("input#auto_utc:checked").length > 0
            utc_date_input.prop("disabled", true)
            utc_time_input.prop("disabled", true)
            auto_utc_update()
        else
            utc_date_input.prop("disabled", false)
            utc_time_input.prop("disabled", false)

    )
    utc_date_input.change(->
        $("input#utc_date").attr("value", $("input#utc_date").val())

    utc_time_input.change(->
        $("input#utc_time").attr("value", $("input#utc_time").val())

auto_utc_update = ->
    auto_utc_input_checked = $("input#auto_utc:checked")
    if auto_utc_input_checked.length > 0
        $.get("/current_utc", (data) ->
            utc_date_input = $("input#utc_date")
            utc_time_input = $("input#utc_time")
            utc_date_input.val(data.utc.date)
            utc_time_input.val(data.utc.ftime)
            setTimeout(auto_utc_update, 1000)
        )
$(document).ready ->
    fire_engines()
$(document).on("page:load", ->
    fire_engines()
)