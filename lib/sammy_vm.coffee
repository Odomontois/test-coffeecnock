define ["sammy","knockout.debug"], (Sammy,ko)->
	class SammyViewModel
		regPatterns:(patterns)->
			self = this		
			(Sammy -> for pattern,func of patterns 
				@get pattern, ((func) -> -> func.call(self,this)) func
				).run()

		observables: (count)-> ko.observable() for i in [1..count]


