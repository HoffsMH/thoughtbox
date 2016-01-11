$(document).ready(function() {
  load_ideas();
  $(document).on("click", ".mark", changeReadStatus);
  $(document).on("keyup", ".search", searchFilter);
  $(document).on("click", ".status-filter", statusFilter);
  $(document).on("click", ".alpha-filter", alphaFilter);
});

function alphaFilter() {
   var sorted = $(IDEAS).sort(function (first, second) {
    return $(first).find(".link-title").text() > $(second).find(".link-title").text();
  });
  $(".ideas").html("");
  $(".ideas").append(sorted);
}

function searchFilter() {
  var value = $(this).val().toUpperCase();
   var filtered = $(IDEAS).filter(function (index, element) {
    title_content  = $(element).find(".link-title").html().toUpperCase();
    return title_content.includes(value);
  });
  $(".ideas").html("");
  $(".ideas").append(filtered);
}

function statusFilter() {
    if ($(this).hasClass("none-filter")) {
      $(".ideas").html("");
      $(".ideas").append($(IDEAS));
      return true
    }
   var read = $(this).hasClass("read-filter") || false;
   var filtered = $(IDEAS).filter(function (index, element) {
     return $(element).hasClass("read-"+read);
  });
  $(".ideas").html("");
  $(".ideas").append(filtered);
}


function changeReadStatus() {
  var id = $(this).closest(".idea").attr("id");
  var read = $("#"+id+" .link-read").text();
  read = (read === "false");
  var url = $("#"+id+" .link-url").text();
  var title = $("#"+id+" .link-title").text();
  $.ajax({
    url: "api/v1/links/" + id,
    method: "patch",
    data: {
      link: {
        read: read,
        url: url,
        title: title
      }
    }
  }).then(function(data) {
    updateIdea(id, data);
  });
}

function load_ideas() {
  //im well aware this is a global
  // 2 hours left.
  IDEAS = $(".idea");
}

function updateIdea(id, args) {
  $("#"+id+" .link-read").text(args.read);
  $("#"+id+" .link-url").text(args.url);
  $("#"+id+" .link-title").text(args.title);


  var read = $("#"+id+" .link-read").text();
  read = (read === "true");
  if (read) {
    $("#"+id).addClass("read-true");
    $("#"+id+" .mark").text("mark as unread");
  } else {
    $("#"+id).removeClass("read-true");
    $("#"+id+" .mark").text("mark as read");
  }
}
