$(document).ready(function(){$("#user-notes-list").on("click",".edit-note-link",function(){event.preventDefault(),t($(this)),n($(this))}),$("#user-notes-list").on("submit",".edit_note",function(){event.preventDefault();var t=$(this).closest("li");$.ajax({url:this.action,type:"patch",data:$(this).serialize(),success:function(n){e(t,n)}})}),$("#add-note-container").on("submit","form",function(){event.preventDefault(),$.ajax({url:this.action,type:"post",data:$(this).serialize(),success:function(t){i(t),s()}})});var t=function(t){t.parent().find(".note-text").css("display","none"),t.parent().find(".edit-note-link").css("display","none")},n=function(t){t.parent().find(".note-text-edit").css("display","inline")},e=function(t,n){t.html(n)},i=function(t){$("#user-notes-ul").append("<li class='skill-note'>"+t+"</li>")},s=function(){$("#new_note")[0].reset()}});