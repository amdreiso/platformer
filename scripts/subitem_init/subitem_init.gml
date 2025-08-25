function subitem_init(){
	
	globalvar SubitemData; SubitemData = ds_map_create();
	globalvar SUBITEM; 
	
	SUBITEM = {
		register: function(subitemID, sprite = -1, normal = function(){}, special = function(){}) {
			var subitem = {};
			subitem.sprite = sprite;
			subitem.normal = normal;
			subitem.special = special;
			
			SubitemData[? subitemID] = subitem;
		},
		
		get: function(subitemID) {
			return (SubitemData[? subitemID] ?? undefined);
		}
	};
	
	SUBITEM.register(SUBITEM_ID.WaterBucket, sWaterBucket_Subitem, 
		function() {
			print("Normal subitem attack");
		},
	
		function() {
			print("Special subitem attack");
		}
	);
	
}