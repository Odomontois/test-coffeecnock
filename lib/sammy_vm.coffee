define ["sammy"], (Sammy)->
	class SammyViewModel
		regPatterns:(patterns)->
			self = this		
			(Sammy -> for pattern,func of patterns 
				@get pattern, ((func) -> -> func.call(self,this)) func
				).run()

