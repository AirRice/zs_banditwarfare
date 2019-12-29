--[[
English is the standard language that you should base your ID's off of.
If something isn't found in your language file then it will fall back to English.

Valid languages (from gmod's menu): bg cs da de el en en-PT es-ES et fi fr ga-IE he hr hu it ja ko lt nl no pl pt-BR pt-PT ru sk sv-SE th tr uk vi zh-CN zh-TW
You MUST use one of the above when using translate.AddLanguage
]]

translate.AddLanguage("en", "English")

LANGUAGE.teamname_bandit							= "Bandits"
LANGUAGE.teamname_human								= "Survivors"
LANGUAGE.win										= "%s Win"
LANGUAGE.draw										= "Draw"
LANGUAGE.deathmatch_mode							= "DEATHMATCH"
LANGUAGE.transmission_mode							= "TRANSMISSION"

LANGUAGE.loser_points_added							= "You get %d points for being on the losing team."
LANGUAGE.winner_points_added						= "You get %d points for being on the winning team."
LANGUAGE.draw_points_added							= "Draw. You get %d points."

LANGUAGE.disconnect_killed							= "%s ragequit after being killed by %s."
LANGUAGE.nail_removed_by							= "%s removed %s's nail."
LANGUAGE.cant_purchase_right_now					= "You cannot purchase this right now."
LANGUAGE.dont_have_enough_points					= "Not enough points."
LANGUAGE.prepare_yourself							= "Prepare for the battle..."
LANGUAGE.purchased_x_for_y_points					= "Purchased %s for %d points!"
LANGUAGE.will_appear_after_respawn					= "This will be given to you after respawning."

LANGUAGE.that_life									= "That life..."
LANGUAGE.x_damage_to_barricades						= "Dealt %d damage to barricades"
LANGUAGE.x_damage_to_enemies						= "Dealt %d damage to enemies"
LANGUAGE.x_kills									= "Killed %d enemies"

LANGUAGE.press_jump_to_free_roam					= "Press JUMP to use free roam camera"
LANGUAGE.press_rmb_to_cycle_targets					= "Right Mouse Button to change spectate target"
LANGUAGE.press_lmb_to_spawn							= "Left Mouse Button to respawn"
LANGUAGE.you_respawned								= "You respawned."

LANGUAGE.respawn_after_x_seconds					= "%d seconds before respawning..."
LANGUAGE.observing_x								= "Spectating: %s (%d)"
LANGUAGE.waiting_for_next_wave						= "Waiting for next wave..."
LANGUAGE.impossible									= "Impossible."
LANGUAGE.trying_to_put_nails_in_glass				= "You can't hammer a nail into glass!"

LANGUAGE.one_sigil_taken_by_x						= "%s have taken a transmitter!"
LANGUAGE.sigil_comms_finished_by_x					= "%s have finished their transmission."
LANGUAGE.sigil_comms_tied							= "Both teams finished their transmissions."

LANGUAGE.sigil_comms_disrupted_x					= "The %s' transmitter has been hacked! The opposite team now controls it."
LANGUAGE.x_killed_all_enemies					    = "%s have killed all enemies."
LANGUAGE.before_wave_cant_go_outside_spawn			= "You cannot leave the spawn before the round starts!"
LANGUAGE.you_have_died								= "You have died"
LANGUAGE.you_were_killed_by_x						= "Killed by %s"
LANGUAGE.arsenal_upgraded							= "Obtained"
LANGUAGE.final_wave									= "Final wave!"
LANGUAGE.cant_do_that_in_classic_mode				= "You may not do that in deathmatch mode."
LANGUAGE.cant_use_x_in_classic_mode					= "You cannot use %s in deathmatch mode!"
LANGUAGE.all_dead									= "All players have died."

LANGUAGE.final_wave_sub								= "The last battle begins!"
LANGUAGE.wave_x_has_begun							= "Wave %d begins!"
LANGUAGE.wave_x_is_over								= "Wave %d is over."
LANGUAGE.sudden_death								= "SUDDEN DEATH! First team to kill all enemies wins!"

LANGUAGE.too_close_to_another_nail					= "You can't put a nail so close to another one."
LANGUAGE.object_too_damaged_to_be_used				= "This object is too damaged to hammer back in."
LANGUAGE.x_turned_on_noclip							= "%s turned on noclip."
LANGUAGE.x_turned_off_noclip						= "%s turned off noclip."

LANGUAGE.points_x									= "Points: %s points"
LANGUAGE.next_wave_in_x								= "Next wave in %s seconds"
LANGUAGE.wave_ends_in_x								= "Wave ends in %s seconds"
LANGUAGE.wave_x_of_y								= "Wave %d/%d"
LANGUAGE.zombie_invasion_in_x						= "Round begins in %s seconds"
LANGUAGE.intermission								= "Intermission"
LANGUAGE.breath										= "O2"
LANGUAGE.waiting_for_players						= "Waiting for players..."
LANGUAGE.requires_x_people							= "Requires %d people"
LANGUAGE.packing_others_object						= "Packing up someone else's object"
LANGUAGE.packing									= "Packing up"
LANGUAGE.loading									= "Loading..."
LANGUAGE.next_round_in_x							= "Map change in %s"
LANGUAGE.warning									= "Warning!"
LANGUAGE.ok_and_no_reminder							= "Don't see again"

LANGUAGE.right_click_to_hammer_nail					= "Right click to hammer a nail in."
LANGUAGE.nails_x									= "Nails: %d"
LANGUAGE.resupply_box								= "Resupply"
LANGUAGE.integrity_x								= "Health: %d%%"
LANGUAGE.empty										= "EMPTY"
LANGUAGE.manual_control								= "MANUAL OVERRIDE"

-- The help file... Quite big! I wouldn't blame you if you didn't translate this part.
LANGUAGE.help_cat_introduction						= "Zombie Survival: Bandit Warfare"
LANGUAGE.help_cat_keys								= "Controls"
LANGUAGE.help_cat_tips								= "Tips"
LANGUAGE.help_cat_barricading						= "Barricading"
LANGUAGE.help_cat_upgrades							= "Points"

LANGUAGE.help_cont_introduction						= [[<p>An endless war has begun between antagonistic bandits and hardened survivors after the zombie apocalypse.</p><br>
<h1>Who will survive?</h1> <br>
<p><h3>There are two gamemodes in Bandit Warfare.</h3></p>
<h2>Transmission</h2> <br>
<p>In Transmission, you are tasked with controlling transmitters around the map in order to send a signal for help before the other team. Both teams have the same objective: to finish the transmission. If a team finishes the transmission first they win the wave. At the end of the game the team with more waves won wins overall.</p>
<p>If you stand next to a transmitter you slowly start to capture it. Having several team members near you in the capture zone increases the speed at which you capture it. Each transmitter adds 0.5 percent to the overall transmission progress once they are controlled.</p>
<p>Remember that the transmitters are the most important in this mode! Even if you kill members of the opposite team you cannot win if you do not control these. If you purchase a "Transmitter Radar", it can help you locate them by showing where they are and how far you are from them.</p>
<p>You can open the weapon loadout menu by pressing and holding the Garry's Mod spawnmenu key ('Q' by default). In this menu you can click each weapon slot to purchase other weapons and replace your original weapon with it. Every time you respawn you will spawn with the three weapons in your loadout, but they will not be given to you until your next respawn.</p>
<p>In Transmission you can use all special tools in the game. EMP guns can help you shut down an enemy transmitter, stopping them from using it to send a transmission temporarily. A hacking tool may be used to immediately take over an enemy transmitter while corrupting part of their existing transmission, reducing their progress. You can purchase these by pressing F2 and are given to you when you buy them immediately unlike weapons.</p>
<p>Points are obtained by killing enemies, assisting your teammates, or capturing transmitters. They are also given out after each round depending on the result of the last wave.</p>
<br>
<h2>Deathmatch</h2> <br>
<p>In deathmatch mode there are no transmitters and the only objective is to kill the entire enemy team. You cannot use loadouts in this mode and everything is purchased using the F2 menu (Also openable with the spawnmenu key). In this mode weapons and other tools are given to you directly.</p>
<p>With deathmatch the entire game is faster paced and you have less time to complete the objective (kill everyone). In addition, when you die in this mode you drop everything you have, including weapons and ammunition. Furthermore, all purchases are 25% cheaper!</p>
]]

LANGUAGE.help_cont_keys					= 
[[<table>
  <caption>Controls</caption>
  <tr>
    <th>Key</th>
    <th>Default Binding</th>
    <th>What they do</th>
  </tr>
  <tr>
    <td>Use</td>
    <td>E</td>
    <td>Open doors/Pick up items/Interact</td>
  </tr>
  <tr>
    <td>gmod_undo</td>
    <td>Z</td>
    <td>Slowly phase through your team's barricades while holding this down.</td>
  </tr>
  <tr>
    <td>Help</td>
    <td>F1</td>
    <td>Show menu with various options</td>
  </tr>
  <tr>
    <td>Spawnmenu</td>
    <td>Q</td>
    <td>Open weapon loadout (Transmission)/Open shop(Deathmatch)</td>
  </tr>
  <tr>
    <td>Shop</td>
    <td>F2</td>
    <td>Open shop</td>
  </tr>
  <tr>
    <td>Information</td>
    <td>F3</td>
    <td>Check weapon stats</td>
  </tr>
  <tr>
    <td>Options</td>
    <td>F4</td>
    <td>Show options menu</td>
  </tr>
   <tr>
    <td>Rotate</td>
    <td>Left Alt</td>
    <td>Press and hold while holding a prop and you can rotate said prop.</td>
  </tr>
</table>]]

LANGUAGE.help_cont_tips								= [[<p>Tips:
<ul><li>Press 'gmod_undo' (Default Z) to enter phase mode where you can phase through friendly barricaded props.</li>
<li>You deal more damage to enemies when you are outnumbered - 25% more to be exact.</li>
<li>More expensive weapons are generally more powerful, but it is crucial to purchase the weapon best suited for the current situation.</li>
<li>Placable tools are placed with the "Attack" key (Default Left Mouse Button), and Reload/Alternate Fire (R and Right Mouse respectively) rotates them before placement.<br> Press and hold Run (Default Shift) to pack them back up for later.</li>
<li>Items with a blue light on them have no owner. You may take them for yourself by using them (Default E).</li>
<li>You can block pathways with heavy props but you won't be able to phase past them if they aren't nailed down.</li>
<li>You can earn points by healing and supplying ammo for your teammates.</li>
<li>You do not collide nor deal damage to your teammates and can recognize them from the icon that appears over their heads.</li>
<li>In Transmission, use the tools to your advantage. EMP tools are great for slowing down the enemy transmission while you take control of their transmitters. Hacking tools can help you gain an edge if you use them on enemy transmitters. Drones can capture transmitters remotely.</li>
<li>Force field barriers are impervious except for their base. shoot them in the base to destroy them.</li>
<li>Scoring headshots mean more damage!</li>
<li>There is a slow down effect if you get hit in the leg. If an enemy is charging at you try shooting them in the knees.</li>
</ul></p>
]]
LANGUAGE.help_cont_barricading						= [[<p>COMING SOON</p>]]
LANGUAGE.help_cont_upgrades							= [[<p>COMING SOON</p>]]