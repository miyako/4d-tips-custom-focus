$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		Form:C1466.controller:=cs:C1710.Controller.new("Focus")
		
	: ($event.code=On Unload:K2:2)
		
	Else 
		
		Form:C1466.controller.updateTextInput()
		
End case 