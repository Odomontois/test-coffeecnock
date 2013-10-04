class SeatReservation
	constructor: (@name,initialMeal) -> 
		@meal = ko.observable initialMeal
		@formattedPrice = ko.computed => 
			price = @meal().price
			if price then "$ #{ price.toFixed 2 }" else "None" 

class ReservationsViewModel
	constructor: ->
		@availableMeals = [
			{ mealName: "Standart (sandwich)",		price:0 }
			{ mealName: "Premium (lobster)",		price:34.95}
			{ mealName: "Ultimate (whole zebra)",	price: 290}
			]
		@seats = ko.observableArray [
			new SeatReservation "Steve",@availableMeals[0]
			new SeatReservation "Bert",@availableMeals[0]
		]
		@removeSeat = (seat) =>
			console.log seat 
			@seats.remove(seat)
		@addSeat = => @seats.push new SeatReservation "", @availableMeals[0]
		@totalSurcharge = ko.computed => (seat.meal().price for seat in @seats()).reduce (a,b)->a+b	

$ -> ko.applyBindings new ReservationsViewModel()