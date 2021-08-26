GM.VoiceSetTranslate = {} 

GM.VoiceSetTranslate["models/player/alyx.mdl"] = "alyx"
GM.VoiceSetTranslate["models/player/barney.mdl"] = "barney"
GM.VoiceSetTranslate["models/player/breen.mdl"] = "male"
GM.VoiceSetTranslate["models/player/combine_soldier.mdl"] = "combine"
GM.VoiceSetTranslate["models/player/combine_soldier_prisonguard.mdl"] = "combine"
GM.VoiceSetTranslate["models/player/combine_super_soldier.mdl"] = "combine"
GM.VoiceSetTranslate["models/player/eli.mdl"] = "male"
GM.VoiceSetTranslate["models/player/gman_high.mdl"] = "male"
GM.VoiceSetTranslate["models/player/kleiner.mdl"] = "male"
GM.VoiceSetTranslate["models/player/monk.mdl"] = "monk"
GM.VoiceSetTranslate["models/player/mossman.mdl"] = "female"
GM.VoiceSetTranslate["models/player/odessa.mdl"] = "male"
GM.VoiceSetTranslate["models/player/police.mdl"] = "combine"
GM.VoiceSetTranslate["models/player/brsp.mdl"] = "female"
GM.VoiceSetTranslate["models/player/corpse1.mdl"] = "zombie"
GM.VoiceSetTranslate["models/player/zombie_classic.mdl"] = "zombie"
GM.VoiceSetTranslate["models/player/zombie_fast.mdl"] = "zombie"
GM.VoiceSetTranslate["models/player/p2_chell.mdl"] = "female"
GM.VoiceSetTranslate["models/player/brsp.mdl"] = "female"

GM.VoiceSets = {}

GM.VoiceSets["zombie"] = {
	["GiveAmmoSounds"] = {
		Sound("npc/fast_zombie/idle1.wav"),
		Sound("npc/fast_zombie/idle2.wav"),
		Sound("npc/fast_zombie/idle3.wav")
	},
	["PainSoundsLight"] = {
		Sound("npc/zombie/zombie_pain6.wav"),
		Sound("npc/zombie/zombie_pain4.wav"),
		Sound("npc/zombie/zombie_pain1.wav"),
		Sound("npc/zombie/zombie_pain2.wav"),
		Sound("npc/zombie/zombie_pain3.wav")
	},
	["PainSoundsMed"] = {
		Sound("npc/zombie/zombie_alert1.wav"),
		Sound("npc/zombie/zombie_alert2.wav"),
		Sound("npc/zombie/zombie_alert3.wav")
	},
	["PainSoundsHeavy"] = {
		Sound("npc/zombie/zombie_voice_idle1.wav"),
		Sound("npc/zombie/zombie_voice_idle10.wav"),
		Sound("npc/zombie/zombie_voice_idle11.wav")
	},
	["DeathSounds"] = {
		Sound("npc/zombie/zombie_die1.wav"),
		Sound("npc/zombie/zombie_die2.wav"),
		Sound("npc/zombie/zombie_die3.wav")
	},
	["EyePoisonedSounds"] = {
		Sound("npc/zombie/zombie_voice_idle6.wav")
	}
}

GM.VoiceSets["male"] = {
	["GiveAmmoSounds"] = {
		Sound("vo/npc/male01/ammo03.wav"),
		Sound("vo/npc/male01/ammo04.wav"),
		Sound("vo/npc/male01/ammo05.wav")
	},
	["PainSoundsLight"] = {
		Sound("vo/npc/male01/ow01.wav"),
		Sound("vo/npc/male01/ow02.wav"),
		Sound("vo/npc/male01/pain01.wav"),
		Sound("vo/npc/male01/pain02.wav"),
		Sound("vo/npc/male01/pain03.wav")
	},
	["PainSoundsMed"] = {
		Sound("vo/npc/male01/pain04.wav"),
		Sound("vo/npc/male01/pain05.wav"),
		Sound("vo/npc/male01/pain06.wav")
	},
	["PainSoundsHeavy"] = {
		Sound("vo/npc/male01/pain07.wav"),
		Sound("vo/npc/male01/pain08.wav"),
		Sound("vo/npc/male01/pain09.wav")
	},
	["DeathSounds"] = {
		Sound("vo/npc/male01/no02.wav"),
		Sound("ambient/voices/citizen_beaten1.wav"),
		Sound("ambient/voices/citizen_beaten3.wav"),
		Sound("ambient/voices/citizen_beaten4.wav"),
		Sound("ambient/voices/citizen_beaten5.wav"),
		Sound("vo/npc/male01/pain07.wav"),
		Sound("vo/npc/male01/pain08.wav")
	},
	["EyePoisonedSounds"] = {
		Sound("ambient/voices/m_scream1.wav")
	}
}

GM.VoiceSets["barney"] = {
	["GiveAmmoSounds"] = {
		Sound("items/ammo_pickup.wav")
	},
	["PainSoundsLight"] = {
		Sound("vo/npc/Barney/ba_pain02.wav"),
		Sound("vo/npc/Barney/ba_pain07.wav"),
		Sound("vo/npc/Barney/ba_pain04.wav")
	},
	["PainSoundsMed"] = {
		Sound("vo/npc/Barney/ba_pain01.wav"),
		Sound("vo/npc/Barney/ba_pain08.wav"),
		Sound("vo/npc/Barney/ba_pain10.wav")
	},
	["PainSoundsHeavy"] = {
		Sound("vo/npc/Barney/ba_pain05.wav"),
		Sound("vo/npc/Barney/ba_pain06.wav"),
		Sound("vo/npc/Barney/ba_pain09.wav")
	},
	["DeathSounds"] = {
		Sound("vo/npc/Barney/ba_ohshit03.wav"),
		Sound("vo/npc/Barney/ba_no01.wav"),
		Sound("vo/npc/Barney/ba_no02.wav"),
		Sound("vo/npc/Barney/ba_pain03.wav")
	},
	["EyePoisonedSounds"] = {
		Sound("vo/npc/Barney/ba_ohshit03.wav")
	}
}

GM.VoiceSets["female"] = {
	["GiveAmmoSounds"] = {
		Sound("vo/npc/female01/ammo03.wav"),
		Sound("vo/npc/female01/ammo04.wav"),
		Sound("vo/npc/female01/ammo05.wav")
	},
	["PainSoundsLight"] = {
		Sound("vo/npc/female01/pain01.wav"),
		Sound("vo/npc/female01/pain02.wav"),
		Sound("vo/npc/female01/pain03.wav")
	},
	["PainSoundsMed"] = {
		Sound("vo/npc/female01/pain04.wav"),
		Sound("vo/npc/female01/pain05.wav"),
		Sound("vo/npc/female01/pain06.wav")
	},
	["PainSoundsHeavy"] = {
		Sound("vo/npc/female01/pain07.wav"),
		Sound("vo/npc/female01/pain08.wav"),
		Sound("vo/npc/female01/pain09.wav")
	},
	["DeathSounds"] = {
		Sound("vo/npc/female01/no01.wav"),
		Sound("vo/npc/female01/ow01.wav"),
		Sound("vo/npc/female01/ow02.wav"),
		Sound("vo/npc/female01/goodgod.wav"),
		Sound("ambient/voices/citizen_beaten2.wav")
	},
	["EyePoisonedSounds"] = {
		Sound("ambient/voices/f_scream1.wav")
	}
}

GM.VoiceSets["alyx"] = {
	["GiveAmmoSounds"] = {
		Sound("vo/npc/female01/ammo03.wav"),
		Sound("vo/npc/female01/ammo04.wav"),
		Sound("vo/npc/female01/ammo05.wav")
	},
	["PainSoundsLight"] = {
		Sound("vo/npc/Alyx/gasp03.wav"),
		Sound("vo/npc/Alyx/hurt08.wav")
	},
	["PainSoundsMed"] = {
		Sound("vo/npc/Alyx/hurt04.wav"),
		Sound("vo/npc/Alyx/hurt06.wav"),
		Sound("vo/Citadel/al_struggle07.wav"),
		Sound("vo/Citadel/al_struggle08.wav")
	},
	["PainSoundsHeavy"] = {
		Sound("vo/npc/Alyx/hurt05.wav"),
		Sound("vo/npc/Alyx/hurt06.wav")
	},
	["DeathSounds"] = {
		Sound("vo/npc/Alyx/no01.wav"),
		Sound("vo/npc/Alyx/no02.wav"),
		Sound("vo/npc/Alyx/no03.wav"),
		Sound("vo/Citadel/al_dadgordonno_c.wav"),
		Sound("vo/Streetwar/Alyx_gate/al_no.wav")
	},
	["EyePoisonedSounds"] = {
		Sound("vo/npc/Alyx/uggh01.wav"),
		Sound("vo/npc/Alyx/uggh02.wav")
	}
}

GM.VoiceSets["combine"] = {
	["GiveAmmoSounds"] = {
		Sound("npc/combine_soldier/vo/hardenthatposition.wav"),
		Sound("npc/combine_soldier/vo/readyweapons.wav"),
		Sound("npc/combine_soldier/vo/weareinaninfestationzone.wav"),
		Sound("npc/metropolice/vo/dismountinghardpoint.wav")
	},
	["PainSoundsLight"] = {
		Sound("npc/combine_soldier/pain1.wav"),
		Sound("npc/combine_soldier/pain2.wav"),
		Sound("npc/combine_soldier/pain3.wav")
	},
	["PainSoundsMed"] = {
		Sound("npc/metropolice/pain1.wav"),
		Sound("npc/metropolice/pain2.wav")
	},
	["PainSoundsHeavy"] = {
		Sound("npc/metropolice/pain3.wav"),
		Sound("npc/metropolice/pain4.wav")
	},
	["DeathSounds"] = {
		Sound("npc/combine_soldier/die1.wav"),
		Sound("npc/combine_soldier/die2.wav"),
		Sound("npc/combine_soldier/die3.wav")
	},
	["EyePoisonedSounds"] = {
		Sound("npc/combine_soldier/die1.wav"),
		Sound("npc/combine_soldier/die2.wav"),
		Sound("npc/metropolice/vo/shit.wav")
	}
}

GM.VoiceSets["monk"] = {
	["GiveAmmoSounds"] = {
		Sound("vo/ravenholm/monk_giveammo01.wav")
	},
	["PainSoundsLight"] = {
		Sound("vo/ravenholm/monk_pain01.wav"),
		Sound("vo/ravenholm/monk_pain02.wav"),
		Sound("vo/ravenholm/monk_pain03.wav"),
		Sound("vo/ravenholm/monk_pain05.wav")
	},
	["PainSoundsMed"] = {
		Sound("vo/ravenholm/monk_pain04.wav"),
		Sound("vo/ravenholm/monk_pain06.wav"),
		Sound("vo/ravenholm/monk_pain07.wav"),
		Sound("vo/ravenholm/monk_pain08.wav")
	},
	["PainSoundsHeavy"] = {
		Sound("vo/ravenholm/monk_pain09.wav"),
		Sound("vo/ravenholm/monk_pain10.wav"),
		Sound("vo/ravenholm/monk_pain12.wav")
	},
	["DeathSounds"] = {
		Sound("vo/ravenholm/monk_death07.wav")
	},
	["EyePoisonedSounds"] = {
		Sound("vo/ravenholm/monk_death07.wav")
	}
}