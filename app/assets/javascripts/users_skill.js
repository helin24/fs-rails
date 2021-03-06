$(document).ready(function() {
	$("#user-notes-list").on("click", ".edit-note-link", function() {
		event.preventDefault();
		hideNoteText($(this));
		showNoteEdit($(this));
	});

	$("#user-notes-list").on("submit", ".edit_note", function() {
		event.preventDefault();
		var $noteLi = $(this).closest("li")
		$.ajax({url: this.action, type: "patch", data: $(this).serialize(), success: function(response) {
			updateNote($noteLi, response);
			// showNoteText($noteLi);
			// hideNoteEdit($noteLi);
			}
		});
	});

	$("#add-note-container").on("submit", "form", function() {
		event.preventDefault();
		$.ajax({url: this.action, type: "post", data: $(this).serialize(), success: function(response) {
			addNote(response);
			clearNoteAdd();
			}
		});
	});

	// $(document).on("click", ".delete-note-link a", function(event) {
	// 	event.preventDefault();
	// 	var $elem = $(this);
	// 	var action = "../notes/" + $elem.parent().attr("id");
	// 	debugger;
	// 	$.ajax({url: action, type: "delete", success: function(response) {
	// 		$elem.closest("li").remove();
	// 		debugger;
	// 		}
	// 	});
	// })

	// Add listener for clicking off somewhere else to hide edit window and prevent opening of more than one edit form

	var hideNoteText = function($elem) {
		$elem.parent().find(".note-text").css("display", "none");
		$elem.parent().find(".edit-note-link").css("display", "none");
	};

	var showNoteText = function($elem) {
		$elem.parent().find(".note-text").css("display", "inline-block");
		$elem.parent().find(".edit-note-link").css("display", "inline-block");
	};

	var hideNoteEdit = function($elem) {
		$elem.parent().find(".note-text-edit").css("display", "none");
	};

	var showNoteEdit = function($elem) {
		$elem.parent().find(".note-text-edit").css("display", "inline");
	};

	var updateNote = function($noteLi, response) {
		$noteLi.html(response)
	};

	var addNote = function(noteHtml) {
		$("#user-notes-ul").append("<li class='skill-note'>" + noteHtml + "</li>");
	};

	var clearNoteAdd = function() {
		$("#new_note")[0].reset();
	}
});