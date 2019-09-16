// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery_ujs

document.addEventListener("turbolinks:load", function() {

  var courseImage = document.querySelector('.course-image');

  function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
          var span = document.createElement('span');
          span.innerHTML = ['<img class="course-preview-thumb" src="', e.target.result,
            '" title="', escape(theFile.name), '"/>'
          ].join('');
          document.getElementById('list').insertBefore(span, null);
        };
      })(f);
      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }

  if (courseImage) {
    this.addEventListener('change', handleFileSelect, false);
  }

});


setTimeout("$('.notification').fadeOut(3000).slideUp(500)");
$(document).ready (function () {

$(document).on("click","#add-q", function() {
  $("#main").append($(".add-from").html());
});

$(document).on("click","#add-checkbox-form", function() {
  $("#main").append($("#checkbox-form").html());
});

$(document).on("click","#add-radio-form", function() {
  $("#main").append($("#radio-form").html());
});

$(document).on("click",".hide-q", function() {
 $(this).parent().hide();
});

$(document).on ("click", ".checkbox", function () {
  $("#cont").append($("#box").html());
});

$(document).on ("click", ".radio-add", function () {
  $("#radio-cont").append($("#radio-box").html());
});


$(document).on ("click", ".answer", function () {
  //debugger

  $(this).parent().append($(".add-from").html());
  $(this).hide();
  //$(this).find(".answer-field").append($(".add-from").html());
});

$(document).on('change','.chp', function(e){
  if (this.checked) {
    $(this).parent().find('.hid-f').remove();
  }
  if (this.checked == false){
    $('#box1').find('.hid-f').clone().prependTo($(this).parent());
 }
});

$(document).on('change','.rd', function(e){
  var active = $('#radio-cont').find(".active");
  if (active.length > 0) {
    active.removeClass("active");
    $('#box3').find('.hid-f').clone().prependTo(active);
  } 
  $(this).parent().addClass("active");
  $(this).parent().find('.hid-f').remove();
});

});