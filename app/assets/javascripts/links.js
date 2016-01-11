$(document).ready(function() {
  $(document).on("click", ".mark", function() {

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
  });
});


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
