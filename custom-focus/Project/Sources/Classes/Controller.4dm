Class constructor($focus : Text)
	
	This:C1470.borderStyleWithFocus:=Border None:K42:27
	This:C1470.borderStyleWithoutFocus:=Border None:K42:27
	This:C1470.hideFocusRectangle:=True:C214
	This:C1470.backgroundWithFocus:=0x00FEFECC
	This:C1470.backgroundWithoutFocus:=Background color:K23:2
	This:C1470.focusObjectName:=$focus
	This:C1470.focusObjectOffset:=3
	
	This:C1470._updateFocus()._enableEvents()
	
Function _enableEvents()->$this : cs:C1710.Controller
	
	$this:=This:C1470
	
	ARRAY LONGINT:C221($events; 2)
	
	$events{1}:=On Getting Focus:K2:7
	$events{2}:=On Losing Focus:K2:8
	
	OBJECT SET EVENTS:C1239(*; ""; $events; Enable events others unchanged:K42:38)
	
Function _updateFocus($force : Boolean)->$this : cs:C1710.Controller
	
	$this:=This:C1470
	
	$event:=FORM Event:C1606
	
	FORM GET OBJECTS:C898($objectNames; $sources; $pages)
	
	var $foreground; $background : Integer
	
	For ($i; 1; Size of array:C274($objectNames))
		
		$objectName:=$objectNames{$i}
		$type:=OBJECT Get type:C1300(*; $objectName)
		
		Case of 
			: ($type=Object type text input:K79:4)
				
				OBJECT SET BORDER STYLE:C1262(*; $objectName; This:C1470.borderStyleWithoutFocus)
				OBJECT SET FOCUS RECTANGLE INVISIBLE:C1177(*; $objectName; This:C1470.hideFocusRectangle)
				OBJECT GET RGB COLORS:C1074(*; $objectName; $foreground; $background)
				OBJECT SET RGB COLORS:C628(*; $objectName; $foreground; This:C1470.backgroundWithoutFocus)
				
		End case 
		
	End for 
	
	$focusObjectName:=OBJECT Get name:C1087(Object with focus:K67:3)
	
	$shoudUpdate:=($event.code=On Getting Focus:K2:7)
	
	OBJECT SET VISIBLE:C603(*; This:C1470.focusObjectName; False:C215)
	
	If ($shoudUpdate)
		
		OBJECT SET BORDER STYLE:C1262(*; $focusObjectName; This:C1470.borderStyleWithFocus)
		OBJECT GET RGB COLORS:C1074(*; $focusObjectName; $foreground; $background)
		OBJECT SET RGB COLORS:C628(*; $focusObjectName; $foreground; This:C1470.backgroundWithFocus)
		
		var $left; $top; $right; $bottom : Integer
		
		OBJECT GET COORDINATES:C663(*; $focusObjectName; $left; $top; $right; $bottom)
		OBJECT SET COORDINATES:C1248(*; This:C1470.focusObjectName; \
			$left-This:C1470.focusObjectOffset; \
			$top-This:C1470.focusObjectOffset; \
			$right+This:C1470.focusObjectOffset; \
			$bottom+This:C1470.focusObjectOffset)
		
		OBJECT SET VISIBLE:C603(*; This:C1470.focusObjectName; True:C214)
		
	End if 
	
Function updateTextInput() : cs:C1710.Controller : $this
	
	$this:=This:C1470
	
	$event:=FORM Event:C1606
	
	Case of 
		: ($event.code=On Getting Focus:K2:7)
			
			This:C1470._updateFocus()
			
		: ($event.code=On Losing Focus:K2:8)
			
			This:C1470._updateFocus()
			
	End case 