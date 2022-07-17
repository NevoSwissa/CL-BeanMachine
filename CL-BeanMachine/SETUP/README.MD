█▀▀ █   █▀▀█ █  █ █▀▀▄
█   █   █  █ █  █ █  █
▀▀▀ ▀▀▀ ▀▀▀▀  ▀▀▀ ▀▀▀
█▀▀▄ █▀▀ ▀█ █▀ █▀▀ █   █▀▀█ █▀▀█ █▀▄▀█ █▀▀ █▀▀▄ ▀▀█▀▀
█  █ █▀▀  █▄█  █▀▀ █   █  █ █  █ █ ▀ █ █▀▀ █  █   █
▀▀▀  ▀▀▀   ▀   ▀▀▀ ▀▀▀ ▀▀▀▀ █▀▀▀ ▀   ▀ ▀▀▀ ▀  ▀   ▀

█▀▀▄ █▀▀ █▀▀█ █▀▀▄   █▀▄▀█ █▀▀█ █▀▀ █  █  ▀  █▀▀▄ █▀▀
█▀▀▄ █▀▀ █▄▄█ █  █   █ ▀ █ █▄▄█ █   █▀▀█ ▀█▀ █  █ █▀▀
▀▀▀  ▀▀▀ ▀  ▀ ▀  ▀   ▀   ▀ ▀  ▀ ▀▀▀ ▀  ▀ ▀▀▀ ▀  ▀ ▀▀▀

Thank you for downloading the script please follow this steps before running the script:

1 - Add items:
go to "qb-core" then shared folder > items.lua and add this : 

	--Bean Machine
	['bdonut'] 	         			 = {['name'] = 'bdonut', 						['label'] = 'Donut', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bdonut.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Tasty Donut'},
	['bbanana'] 	         		 = {['name'] = 'bbanana', 						['label'] = 'Banana', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bbanana.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Banana'},
	['borange'] 	         		 = {['name'] = 'borange', 						['label'] = 'Orange', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'borange.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Orange'},
	['bapple'] 	         			 = {['name'] = 'bapple', 						['label'] = 'Apple', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bapple.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Red Apple'},
	['bmuffin'] 	         		 = {['name'] = 'bmuffin', 						['label'] = 'Muffin', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bmuffin.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Muffin'},
	['bchocolatemuffin'] 	         = {['name'] = 'bchocolatemuffin', 				['label'] = 'Chocolate Muffin', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bchocolatemuffin.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Chocolate Muffin'},
	['bberrymuffin'] 	         	 = {['name'] = 'bberrymuffin', 					['label'] = 'Berry Muffin', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bberrymuffin.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Berry Muffin'},
	['bmenu'] 	         	 		 = {['name'] = 'bmenu', 						['label'] = 'Bean Machine Menu', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bmenu.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Menu'},
	['bregularcup'] 	         	 = {['name'] = 'bregularcup', 					['label'] = 'Regular Cup', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bregularcup.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Regular Cup'},
	['bsprite'] 	         	 	 = {['name'] = 'bsprite', 						['label'] = 'Sprite', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bsprite.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cup Fill With Sprite'},
	['bcocacola'] 	         	 	 = {['name'] = 'bcocacola', 					['label'] = 'CocaCola', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bcocacola.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cup Fill With Cocacola'},
	['bpepper'] 	         	 	 = {['name'] = 'bpepper', 						['label'] = 'DR.Pepper', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bpepper.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cup Fill With DR.Pepper'},
	['blemonslush'] 	         	 = {['name'] = 'blemonslush', 					['label'] = 'Lemon Slush', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'blemonslush.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cup Fill With Lemon Slush'},
	['borangeslush'] 	         	 = {['name'] = 'borangeslush', 					['label'] = 'Orange Slush', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'borangeslush.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cup Fill With Orange Slush'},
	['bcoffeebeans'] 	         	 = {['name'] = 'bcoffeebeans', 					['label'] = 'Coffee Beans', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bcoffeebeans.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Coffee Beans'},
	['bhighcoffeeglasscup'] 	     = {['name'] = 'bhighcoffeeglasscup', 			['label'] = 'High Coffee Glass', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bhighcoffeeglasscup.png', 	['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Empty High Coffee Glass'},
	['bcoffeeglass'] 	     		 = {['name'] = 'bcoffeeglass', 					['label'] = 'Coffee Glass', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bcoffeeglass.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Empty Coffee Glass'},
	['bstrawberry'] 	     		 = {['name'] = 'bstrawberry', 					['label'] = 'Strawberry', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bstrawberry.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Strawberry'},
	['bhoney'] 	     		 		 = {['name'] = 'bhoney', 						['label'] = 'Honey', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bhoney.png', 				['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Honey'},
	['bmilk'] 	     		 		 = {['name'] = 'bmilk', 						['label'] = 'Milk', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bmilk.png', 				['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Milk'},
	['bcream'] 	     		 		 = {['name'] = 'bcream', 						['label'] = 'Whipped Cream', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bcream.png', 				['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Whipped Cream'},
	['bice'] 	     		 		 = {['name'] = 'bice', 							['label'] = 'Ice', 						['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bice.png', 				['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ice'},
	['bcaramelsyrup'] 	     		 = {['name'] = 'bcaramelsyrup', 			    ['label'] = 'Caramel Syrup', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bcaramelsyrup.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Caramel Syrup'},
	['bcloudcafe'] 	     		 	 = {['name'] = 'bcloudcafe', 					['label'] = 'Cloud Cafe', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bcloudcafe.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cloud Cafe'},
	['bjavachipfrappuccino'] 	     = {['name'] = 'bjavachipfrappuccino', 			['label'] = 'Java Chip Frappuccino', 	['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bjavachipfrappuccino.png', ['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Java Chip Frappuccino'},
	['bhotchoc'] 	     		     = {['name'] = 'bhotchoc', 						['label'] = 'Hot Choc', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bhotchoc.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Hot Choc'},
	['bhoneyhazelnutoatlatte'] 	     = {['name'] = 'bhoneyhazelnutoatlatte', 		['label'] = 'Honey Hazelnut Oat Latte', ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bhoneyhazelnutoatlatte.png',['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Honey Hazelnut Oat Latte'},
	['bstrawberrycreamfrappuccino']  = {['name'] = 'bstrawberrycreamfrappuccino', 	['label'] = 'Strawberry Cream Frappuccino', ['weight'] = 1000, 	['type'] = 'item', 		['image'] = 'bstrawberrycreamfrappuccino.png',['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Strawberry Cream Frappuccino'},
	['bicedcaffelatte'] 	         = {['name'] = 'bicedcaffelatte', 				['label'] = 'Iced Caffe Latte', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bicedcaffelatte.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Iced Caffe Latte'},
	['bespresso'] 	     		 	 = {['name'] = 'bespresso', 					['label'] = 'Espresso', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bespresso.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Espresso'},
	['bespressomacchiato'] 	     	 = {['name'] = 'bespressomacchiato', 			['label'] = 'Espresso Macchiato', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bespressomacchiato.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Espresso Macchiato'},
	['bcaramelfrappucino'] 	     	 = {['name'] = 'bcaramelfrappucino', 			['label'] = 'Caramel Frappucino', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bcaramelfrappucino.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Caramel Frappucino'},
	['bcoldbrewlatte'] 	     	 	 = {['name'] = 'bcoldbrewlatte', 				['label'] = 'Cold Brew Latte', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bcoldbrewlatte.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cold Brew Latte'},
	['bhotchocolatepowder'] 	     = {['name'] = 'bhotchocolatepowder', 			['label'] = 'Hot Chocolate Powder', 	['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bhotchocolatepowder.png', 	['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Hot Chocolate Powder'},
	['bstrawberryvanillaoatlatte'] 	 = {['name'] = 'bstrawberryvanillaoatlatte',	['label'] = 'Strawberry Vanilla Oat Latte',['weight'] = 1000, 	['type'] = 'item', 		['image'] = 'bstrawberryvanillaoatlatte.png',['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Strawberry Vanilla Oat Latte'},
	['bespressocoffeecup'] 	 		 = {['name'] = 'bespressocoffeecup',			['label'] = 'Espresso Coffee Cup',		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bespressocoffeecup.png',	['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Espresso Coffee Cup'},
    

Video: https://streamable.com/sspxn5

2 - Add the job:
go to "qb-core" then shared folder > jobs.lua and at least under line 4 :

    ["beanmachine"] = {
        label = "Bean Machine",
        offDutyPay = false,
        defaultDuty = false,
        grades = {
            ['0'] = {
                name = 'Worker',
                payment = 30,
            },
            ['1'] = {
                name = 'Vice Boss',
                payment = 70,
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 130,
            },
        }
    },

Video: https://streamable.com/os10ii

3 - Add images to inventory
here you have images folder copy the images inside that folder and put it inside "qb-inventory"

Video: https://streamable.com/0bb51c

Have more questions / issues ? feel free to open a ticket in our discord server : https://discord.gg/kGPECGG27Q