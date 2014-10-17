$(document).ready(function() {
	$("#user-notes-list").on("click", ".edit-note-link", function() {
		hideNoteText($(this));
		showNoteEdit($(this));
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
	}
});