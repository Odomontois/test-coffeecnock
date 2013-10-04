require.config 
	baseUrl: '/lib'
	paths: app: "app"

require ["jquery", 
		 "knockout.debug",
		 "sammy_vm"], (
		 	$,
		 	ko,
		 	SammyVM) ->
	class WebMailViewModel extends SammyVM
		constructor: ->
			@folders = ["Inbox","Archive","Sent","Spam"]
			@chosenFolderId = ko.observable()
			@chosenFolderData = ko.observable()
			@chosenMailData = ko.observable()

			@goToFolder = (folder) => location.hash = folder
			@goToMail = (mail) => location.hash = "#{mail.folder}/#{mail.id}"

			@regPatterns
				'#:folder': @hashFolder
				'#:folder/:mailId': @hashMail
				'': @hashDefault		

		hashFolder:(sammy)->
			@chosenFolderId sammy.params.folder
			@chosenMailData null
			$.ajax
				url: "/mail/#{sammy.params.folder}.json"
				success: @chosenFolderData
				error: => @chosenFolderData null

		hashMail:(sammy)->
			@chosenFolderId sammy.params.folder
			@chosenFolderData null
			$.ajax
				url:"/mail/#{sammy.params.mailId}.json"
				success: @chosenMailData
				error: @chosenMailData null
		hashDefault:(sammy)->
			sammy.app.runRoute 'get', '#Inbox'





	$ -> ko.applyBindings new WebMailViewModel()