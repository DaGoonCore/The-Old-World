/datum/job/penitent //the plan is to have penitent be a default landing job, I will eventually add a randomized system that gives different loadouts much like the migrant system of lifeweb
	title = "Pilgrim"
	department_flag = PIL
	social_class = SOCIAL_CLASS_MIN //these boys are gross
	total_positions = 6 //maybe open up more of these when we figure out other classes and depending on player count
	spawn_positions = 6
	supervisors = "The Holy Inquisition"
	selection_color = "#515151"
	access = list(access_hydroponics,)
	minimal_access = list(access_maint_tunnels)
	outfit_type = /decl/hierarchy/outfit/job/penitent
	latejoin_at_spawnpoints = TRUE


	equip(var/mob/living/carbon/human/H)
		H.warfare_faction = IMPERIUM
		..()
		H.add_stats(rand(6,11), rand(7,12), rand(8,12), rand (8,11)) //they suck and are supposed to suck
		H.fully_replace_character_name("Penitent [H.real_name]")
		H.warfare_language_shit(LANGUAGE_LOW_GOTHIC)
		H.assign_random_quirk()
		to_chat(H, "<span class='notice'><b><font size=3>You are a Pilgrim. You left your home with little in search of more. Rumors of a holy site drew you to this planet and now life is in your hands. Go to your pilgrim tab and select your fate. </font></b></span>")
		if(announced)
			H.say("Forgive me, God-Emperor!")



		H.verbs += list(
			/mob/living/carbon/human/proc/penitentclass,
		)
/*
Pilgrim Fate System
*/

//yeah this might be the most retarded way of doing it but it works - plz no bully Matt

/mob/living/carbon/human/proc/penitentclass(var/mob/living/carbon/human/M)
	set name = "Select your class"
	set category = "Pilgrim"
	set desc = "Choose your new profession on this strange world."
	if(!ishuman(M))
		to_chat(M, "<span class='notice'>How tf are you seeing this, ping Wel Ard immediately</span>")
		return
	if(M.stat == DEAD)
		to_chat(M, "<span class='notice'>You can't choose a class when you're dead.</span>")
		return

	var/mob/living/carbon/human/U = src
	var/fates = list() //lists all possible fates
	fates += pick("Farmer","Tester","test2",) //adds a fate randomly to essentially give rng pick
	fates += pick("test1","test3",) //adds a fate randomly to essentially give rng pick
	fates += pick("Miner","test",) //adds a fate randomly to essentially give rng pick

	M.mind.store_memory(fates) //should stop people from closing and rerolling fates

	var/classchoice = input("Choose your fate", "Available fates") as anything in fates


	switch(classchoice)
		if("Miner")
			equip_to_slot_or_del(new /obj/item/clothing/suit/innapron, slot_wear_suit)
			U.verbs -= list(/mob/living/carbon/human/proc/penitentclass,
			)

	/*
	var/classchoice = input("Choose your fate", "Available fates") as null|anything in list("Miner", "Farmer", "Celebrity")
	switch(classchoice)
		if("Miner")
			equip_to_slot_or_del(new /obj/item/clothing/suit/innapron, slot_wear_suit)
			U.verbs -= list(/mob/living/carbon/human/proc/penitentclass,
			)

*/

/datum/job/innkeeper  //so that the inn always has someone working
	title = "Innkeeper"
	department_flag = PIL
	social_class = SOCIAL_CLASS_MED //better off than your average gross pilgrim
	total_positions = 1
	spawn_positions = 1
	open_when_dead = 1
	supervisors = "Money"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_bar) //TODO, figure out access stuff for them
	outfit_type = /decl/hierarchy/outfit/job/innkeeper
	latejoin_at_spawnpoints = TRUE

	equip(var/mob/living/carbon/human/H)
		H.warfare_faction = IMPERIUM
		..()
		H.add_stats(rand(6,11), rand(7,12), rand(8,12), rand (8,11)) //they suck and are supposed to suck
		H.warfare_language_shit(LANGUAGE_LOW_GOTHIC)
		H.assign_random_quirk()
		to_chat(H, "<span class='notice'><b><font size=3>You landed on this outpost some time ago, with the savings you had, you opened an inn hoping to grow your wealth serving the various pilgrims and travelers. Trade with gatherers and the outpost to always stay stocked so that no paying customer will be without food and drink. You have a full kitchen, alcohol and small farm to grow what you need. </font></b></span>")


//loadouts below here
/decl/hierarchy/outfit/job/penitent
	name = OUTFIT_JOB_NAME("Pilgrim")
	uniform = /obj/item/clothing/under/rank/penitent
	suit = /obj/item/clothing/suit/raggedrobe
	id_type = /obj/item/card/id/pilgrim/penitent
	pda_type = /obj/item/device/pda/penitent
	neck = /obj/item/reagent_containers/food/drinks/canteen
	head = /obj/item/clothing/head/plebhood
	l_ear = null
	r_ear = null

/decl/hierarchy/outfit/job/innkeeper
	name = OUTFIT_JOB_NAME("Innkeeper")
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/innapron
	id_type = /obj/item/card/id/pilgrim/innkeeper
	pda_type = /obj/item/device/pda/penitent
	back = /obj/item/storage/backpack/satchel/warfare
	neck = /obj/item/reagent_containers/food/drinks/canteen
	head = /obj/item/clothing/head/bardhat
	backpack_contents = list(/obj/item/thrones/bundle/t50=1) //they have some money for trade
	l_ear = null
	r_ear = null
	shoes = /obj/item/clothing/shoes/vigilante
