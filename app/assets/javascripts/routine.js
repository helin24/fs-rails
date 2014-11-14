$(function() {

  $(".group-item").on("click", function() {
		updateGroup(this);
  });

	var setInitialGroup = function() {
		var activeGroup = "Level";
		var activeId = 1;		
		selectGroup(activeGroup, activeId);
	};

	var deselectAll = function() {
		$(".active-group").removeClass("active-group");
		$(".active-element").removeClass("active-element");
	};

	var selectGroup = function(activeGroup, activeId) {
		deselectAll();
		$(".group-item#" + activeGroup + "-" + activeId).addClass("active-group");
		$(".element-item." + activeGroup + "." + activeId).addClass("active-element");
		$("#custom-element").addClass("active-element")
	};

	var updateGroup = function(listItem) {
		var text = listItem.id.split('-');
		activeGroup = text[0];
		activeId = text[1];
		selectGroup(activeGroup, activeId);
	};

	setInitialGroup();

  // Draggable and droppable stuff

  $(".element-item").draggable({scroll: false, appendTo: ".routine", helper: "clone"});

  $("#routine-box").droppable({
  	activeClass: "dragged",
  	drop: function(event, ui) {
      if(ui.draggable.hasClass("element-item")) {
        $item = ui.draggable.clone();
        makeItemDraggable($item);
      } else {
        $item = ui.draggable;
      }
      $(this).append($item);
      positionItem($item, $(this), ui);
    }
  });

  $("#routine-box").on("click", ".delete-element", function() {
    $(this).parent().remove();
  });

  var makeItemDraggable = function($item) {
    $item.removeClass("element-item");
    $item.addClass("routine-item");
    $item.draggable({scroll: false, containment: "parent"});
  };

  var positionItem = function($item, $box, ui) {
    var itemPos = ui.offset;
    var boxPos = $box.offset();
    var top = itemPos.top - boxPos.top;
    var left = itemPos.left - boxPos.left;
    var boxHeight = $box.height();
    var boxWidth = $box.width();
    top = Math.max(0, top);
    top = Math.min(top, boxHeight);
    left = Math.max(0, left);
    left = Math.min(left, boxWidth);
    $item.css({position: 'absolute', top: top, left: left})  
  }

  // Creating and editing a routine

  $(".new_routine").on("submit", function() {
  	event.preventDefault();
  	$.ajax({url: this.action, type: "post", data: $(this).serialize(), success: function(response) {
  		replaceForm(response);
  		changeTitle(response)
  		}
  	});
  });

  $("#routine-info").on("submit", ".edit_routine", function() {
    event.preventDefault();
    $.ajax({url: this.action, type: "put", data: $(this).serialize(), success: function(response) {
      changeTitle($(response));
      }
    });
  });

  var replaceForm = function(form) {
  	$("#routine-info").html(form);
  };

  var changeTitle = function(response) {
    $response = $(response)
  	var title = $response.children("#routine_name").attr("value");
  	var id = $response.children("#routine_id").attr("value");
  	var link = "routines/" + id + "/edit";
  	var insertHtml = "<a href='" + link + "'>" + title + "</a>"
  	$("#nav-bar .selected").html(insertHtml);
  };

});


// Need a class called Element that's created
// Element should have properties top, left
// Element should eventually have ID
// 