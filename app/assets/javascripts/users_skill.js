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

	// ajaxify add and delete

	// Add listener for clicking off somewhere else to hide edit window and prevent opening of more than one edit form

	var hideNoteText = function($elem) {
		$elem.parent().find(".note-text").css("display", "none");
		$elem.parent().find(".edit-note-link").css("display", "none");
	};

	var showNoteText = function($elem) {
		$elem.parent().find(".note-text").css("display", "inline");
		$elem.parent().find(".edit-note-link").css("display", "inline");
	};

	var hideNoteEdit = function($elem) {
		$elem.parent().find(".note-text-edit").css("display", "none");
	};

	var showNoteEdit = function($elem) {
		$elem.parent().find(".note-text-edit").css("display", "inline");
	};

	var updateNote = function($noteLi, response) {
		var $noteText = $noteLi.find(".note-text");
		updateNoteText($noteText, response);
		showNoteText($noteText);

		var $noteEdit = $noteLi.find(".note-text-edit");
		updateNoteEdit($noteEdit, response);
		hideNoteEdit($noteEdit.parent());
	};

	var updateNoteText = function($noteText, info) {
		$noteText.html(info.text);
	};

	var updateNoteEdit = function($noteEdit, info) {
		$inputText = $noteEdit.find("#note_text");
		$inputSource = $noteEdit.find("#note_source");
		$inputPublic = $noteEdit.find("#note_public");

		$inputText.attr("value", info.text);
		$inputSource.attr("value", info.source);
		$inputPublic.attr("value", info.public);
	};

	var addNote = function(noteHtml) {
		$("#user-notes-ul").append("<li>" + noteHtml + "</li>");
	};

	var clearNoteAdd = function() {
		$("#new_note")[0].reset();
	}
});