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

  var loadRoutine = function() {
    var routine = new Routine();
    var elements = $("#routine-box").find("li")
    for(i = 0; i < elements.length; i++) {
      var $listItem = $(elements[i])
      var element = new Element($listItem);
      routine.elements.push(element);
    }
    return routine;
  }

	setInitialGroup();
  var routine = loadRoutine();

  // Draggable and droppable stuff

  $(".element-item").draggable({scroll: false, appendTo: ".routine", helper: "clone"});
  $(".routine-item").draggable({scroll: false, containment: "parent"});

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
    $(this).parent().addClass("deleted");
    $(this).parent().css({display: "none"});
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
    $item[0].setAttribute("top", top)
    $item[0].setAttribute("left", left)
  }

  // Creating and editing a routine

  $(".new_routine").on("submit", function() {
    event.preventDefault();
    var routineData = $(this).serialize();
    routineData = routineData + '&routine_elements=' + JSON.stringify(loadRoutine());
    var $button = $(this).find("input[type='submit']");
    $.ajax({url: this.action, type: "post", data: routineData, success: function(response) {
      replaceForm(response);
      changeTitle(response);
      $button = $("input[type='submit']");
      flashSavedButton($button);
      }
    });
  });

  // $("input[value=Delete]").on("click", function(event) {
  //   event.stopImmediatePropagation();
  //   var certain = confirm("Are you sure you want to delete this routine?");
  //   if (certain == true) {
  //     var $form = $(this).closest("form");
  //     var routineData = $form.serialize();
  //     var path = $form.attr("action");
  //     debugger;
  //     $.ajax({url: path, type: "delete", data: routineData, succes: function(response) {
  //       }
  //     });
  //   }
  // });

  $("#routine-info").on("click", "input[value=Save]", function() {
    event.preventDefault();
    form = this.parentElement
    var $button = $(form).find("input[type='submit']").first();
    var routineData = $(form).serialize();
    routineData = routineData + '&routine_elements=' + JSON.stringify(loadRoutine());
    $.ajax({url: form.action, type: "put", data: routineData, success: function(response) {
      changeTitle($(response));
      flashSavedButton($button);
      }
    });
  });

  $("#routine-box").on("click", "#custom-element", function() {
    $(this).find("#custom-text").css({display: "none"});
    $(this).find(".custom-input").css({display: "inline"});
  });

  $("#routine-box").on("focusout", "#custom-element", function() {
    updateCustomInput($(this));
    updateCustomText($(this));
  });

  replaceForm = function(form) {
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

  var updateCustomInput = function($customElem) {
    $input = $customElem.find(".custom-input");
    $input.attr("value", $input.val());
    $input.css({display: "none"});
  };

  var updateCustomText = function($customElem) {
    var name = $customElem.find(".custom-input").val();
    var $div = $customElem.find("#custom-text")
    $div.text(name);
    $div.css({display: "inline"});
  };

  var flashSavedButton = function($button) {
    var oldColor = $button.css("color");
    var oldBackgroundColor = $button.css("background-color");
    var oldBorderColor = $button.css("border-color");
    $button.css({"color": "#000"});
    $button.css({"background-color": "#08A20C"});
    $button.css({"border-color": "#045106"});
    $button.attr("value", "Saved!")
    setTimeout(
      function() {
        $button.css("color", oldColor);
        $button.css("background-color", oldBackgroundColor);
        $button.css("border-color", oldBorderColor);
        $button.attr("value", "Save")
      }, 1200);
  };

});

var Routine = function() {
  this.elements = []
}

var Element = function($listItem) {
  this.id = $listItem.attr("element-id");
  this.top = $listItem.attr("top");
  this.left = $listItem.attr("left");
  this.elementable_type = $listItem.attr("type");
  this.elementable_id = $listItem.attr("type-id");
  if($listItem.attr("id") === "custom-element"){
    this.custom_name = $listItem.find(".custom-input").attr("value");
  };
  if($listItem.hasClass("deleted")) {
    this.deleted = true;
  }
}