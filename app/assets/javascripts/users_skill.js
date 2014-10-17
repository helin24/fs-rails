$(document).ready(function() {
	$("#user-notes-list").on("click", ".edit-note-link", function() {
		event.preventDefault();
		hideNoteText($(this));
		showNoteEdit($(this));
	});

	$("#user-notes-list").on("submit", ".edit_note", function() {
		event.preventDefault();
		var $note = $(this)
		$.ajax({url: this.action, type: "patch", data: $(this).serialize(), success: function(response) {
				updateNote(response, $note);
				showNoteText();
				hideNoteEdit();
			}
		});
	});

	var hideNoteText = function($elem) {
		$elem.parent().find(".note-text").css("display", "none");
		$elem.parent().find(".edit-note-link").css("display", "none");
	};

	var showNoteText = function($elem) {
		$elem.parent().find(".note-text").css("display", "inline");
		$elem.parent().find(".edit-note-link").css("display", "inline");
	};

	var hideNoteEdit = function() {
		$elem.parent().find(".note-text-edit").css("display", "none");
	};

	var showNoteEdit = function($elem) {
		$elem.parent().find(".note-text-edit").css("display", "inline");
	};

	var updateNote = function(info, $note) {
		// Update note text
		// Update note edit
		$note.closest("li")		
		debugger;
	};
});