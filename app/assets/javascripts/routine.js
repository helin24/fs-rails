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

  $(".draggable").draggable({scroll: false, appendTo: ".routine", helper: "clone"});

  $(".time-mark").droppable({
  	activeClass: "dragged",
  	drop: function(event, ui) {
  		$(this).after(ui.draggable);
  	}
  });

  // Creating a new routine

  $(".new_routine").on("submit", function() {
  	event.preventDefault();
  	$.ajax({url: this.action, type: "post", data: $(this).serialize(), success: function(response) {
  		replaceForm(response);
  		changeTitle(response)
  		}
  	});
  });

  $()

  var replaceForm = function(form) {
  	$("#routine-info").html(form);
  };

  var changeTitle = function(response) {
  	var title = response.name;
  	var id = response.id;
  	var link = "routines/" + id + "/edit";
  	var insertHtml = "<a href='" + link + "'>" + title + "</a>"
  	$("#nav-bar .selected").html(insertHtml);
  };

});