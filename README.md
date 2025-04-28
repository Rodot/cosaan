# Game Design Document

## Overview

Webapp party game. Players are crash-landed on an island, they struggle to balance collaborative survival with personal fame. Shared resources management and social deception awaits!

## Characteristics

- Target audience/age range: 16-40 years old (mature textual content)
- Player count: 4 😃 Players + 28 🤖 NPCs
- Estimated playtime: 60 minutes (2 min x 30 days)
- Complexity level: Play right away, but with depth for strategy
- D&D feel: Virtual 🎲 D20 dice rolls for all 💪 Actions and 🎲 Events
- Theme: 😃 Players play as themselves, modern times, crash-landed on a deserted island, waiting 30 days for rescue (problem => no reason to look for 🏆 Fame)
- Visual: text-based, default web app style, material design system, mdi icons
- Victory condition: survive 30 days with the most 🏆 Fame
- If a 😃 Player dies, they reincarnate into one of the 🤖 NPCs

## Reference Games

- Turned based survival
  - This war of mine
  - Frost punk
- Social deception
  - Among Us
  - Secret Hitler
  - TTT Game mode

## Key Player Activities

- **Resource Gathering**
  - Get 🍎 Food and 🌲 Wood
- **🏫 Village development**
  - Build or upgrade 🏠 Buildings
- **Social Interactions**
  - Form alliances with other 😃 Players and 🤖 NPCs
  - Vote on 🏫 village 📑 policies
  - Trade personal 🏆 Fame for communal benefits
  - Sabotage other 😃 Players' efforts (at risk of reputation loss)
- **Crisis Management**
  - Respond to random 🎲 Events (weather, disease, raiders)
  - Allocate emergency resources
  - Rescue endangered 👤 Villagers

## Tension Mechanics

- Limited daily 💪 Actions force difficult choices
- Resource scarcity increases competition
- Random 🎲 Events test alliances
- Hidden personal objectives create suspicion

## User flow

- **🎮 Lobby**

  - Visit home page with pitch and core principles (🍎 Food, 🌲 Wood, 🏆 Fame, day cycle...)
  - Enter 😃 Player name to enable "Create game" button
  - Click on "Create game"
  - View the lobby with 😃 Player alone + CTA to share a link/QR for other 😃 Players to join
  - Wait until there are 4 😃 Players in the lobby
  - Click "Start game"

- **🎲 Event Phase (night)** (if applicable)
  - 🎲 Event phase transition screen
  - If a 🎲 Event appears, it's revealed and rolled
  - View a description of the 🎲 Event
  - View dice roll of the 🎲 Event
  - View outcome of the 🎲 Event
  - 🔥 Modifiers do their effect for the day

- **🌄 Planning Phase (morning)**
  - Planning phase transition screen
  - View available shared resources: 🍎 Food, 🌲 Wood, 🏠 Buildings, 👤 Villagers
  - View 🏆 Fame of top 3 villagers only
  - View available personal resources: ⚡ Energy, 🏆 Fame
  - View a list of available 💪 Actions with their expected cost and outcome and a checkbox
    - Some actions have a dropdown menu to change their parameter: amount of 🍎 Food to eat, which 🏠 Building to construct
  - Check boxes for 💪 Actions to do, see the ⚡ Energy bar deplete to preview energy used by actions
  - Click on "Start the day"
  - See "Waiting for XXX" (😃 Player who didn't Start the Day)
  - Communicate/negotiate with other 😃 Player

- **🌞 Action Phase (day)**
  - Action phase transition screen
  - All 👤 Villagers 💪 Actions are rolled, by decreasing order of 🏆 Fame.
  - If several 👤 Villagers chose to do the same action, they join the first one doing it.
  - See action of all villagers get rolled and their individual outcome
    - Show separately collaboration bonus when applicable
  - See Village resources move as actions affect them
  - Each 💪 Actions' outcome is shown as they are rolled

- **🌙 Consequences Phase (evening)**
  - Consequences phase transition screen
  - Total resource earned/used shown
  - See village resources plus their variation for the day (green/red difference)
  - Total 🏠 Building construction progress shown
  - Total Resource consumption calculated

- **🗳️ Voting Phase** (if applicable)
  - See the decision to be voted, possible outcomes
  - See who voted for what in real time
  - See "waiting for..." (players who didn't vote)
  - See vote resolution animation
  - See vote outcome and effect
  - Voting on communal decisions if necessary

- **🔃 Loop** Go back to 🎲 Event Phase until 30 days passed or all villagers are dead

- **🏁 Game End**

  - See top 3 villagers by 🏆 Fame
  - See comments about special achievements (got the most food, etc.)
  - Click on "play again" button
  - Enter a new lobby

## Game elements

- **🤖 NPC**
- **😃 Player**
- **🏫 Village**
- **👤 Villagers**
  - Either human 😃 Player or 🤖 NPC
  - Either dead or alive
- **🏆 Fame**
  - Per 👤 Villager
  - Earned through personal achievements, communal contributions, achieve hidden personal objective
  - Used for voting and influencing village decisions.
- **⚡ Energy**
  - Per 👤 Villager
  - Replenished daily, consumes 🍎 Food
  - Chance to die if it's not replenished, roll 1D20
  - Used to do 💪 Actions
- **🍎 Food**
  - Per 🏫 Village
  - Gathered through hunting, foraging, cannibalism
  - Consumed daily by 👤 Villagers even if they don't use ⚡ Energy
- **🌲 Wood**
  - Per 🏫 Village
  - Collected from the forest, beach
  - Used for building and crafting.
- **🏠 Buildings**
  - Per 🏫 Village
  - Constructed by players using 🌲 Wood
  - Provide benefits to the village (🍎 Food, 🌲 Wood, 🏆 Fame...)
  - Can be destroyed by random events or sabotage
- **📑 Policies**
  - Per 🏫 Village
  - Change what 💪 Actions can be done
- **✅ Decisions**
  - Choose between different options
  - One choice per 👤 Villager, one result per 🏫 Village
  - Decision mechanism depends on the 📑 Policy (see below)
  - Can be used to answer a vote to change 📑 Policies
  - Can be used to chose how to react to an 🎲 Event (foreigner asks for 🍎 Food: give him or not?)
- **💪 Actions**
  - See below
- **🎲 Events**
  - Per 🏫 Village (but can affect only some 👤 Villagers)
  - 1 per 🌞 Day Action Phase
  - Outcome based 1D20 dice roll
  - Earn/loose 🍎 Food 🌲 Wood 🏠 Buildings ⚡ Energy 🏆 Fame 👤 Villagers
  - Kill 👤 Villagers
  - Add 🔥 Modifiers
  - An 🎲 Event is basically an 💪 Action played by the game
- **🔥 Modifiers**
  - Per 🏫 Village or per 👤 Villager
  - Temporary
  - ⚡ Energy can be spent on 💪 Actions to attempt to stop/maintain the 🔥 Modifier

## Initial Game State

- 📑 Policies
  - Food: Omnivore
  - Food: All you can eat
  - Decision: Democratic weighted random
- No 🍎 Food and 🌲 Wood
- Full ⚡ Energy

## 💪 Actions mechanics

Action outcome is determined by the difference between 1D20 roll the 💪 Action difficulty threshold

All 💪 Actions have 5 levels of outcome (probabilities for a "regular" 💪 Action difficulty):

- Excellent (5%): extra unrelated outcome + 🏆 Fame
- Good (20%): increased outcome
- Normal (50%): expected outcome
- Bad: (20%): limited or no outcome
- Horrible (5%): building destruction, resource loss, death

For a given 💪 Action, each level of outcome can have several outcomes to randomly pick from

5 levels of difficulty

- Trivial
- Easy
- Regular
- Hard
- Balsy

Actions characteristics

- Most 💪 Actions have requirement to be doable, not visible until then.
- Most 💪 Actions can be done collaboratively (hunting, constructing...)
  - which reduces ⚡ Energy cost for all participants (diminishing returns)
  - or diminish difficulty, increasing the outcome and reducing the risk ?
- Most 💪 Actions can be done secretly. If they fail, their author(s) will be revealed publicly.

## 💪 Actions available

- Eat
  - Consumes 🍎 Food to replenish ⚡ Energy
- Berries Foraging
  - Outcome: 🍎 Food
  - Yield: low
  - Variability: low
  - Danger: low
- Rabbit trapping
  - Outcome: 🍎 Food
  - Yield: medium
  - Variability: medium
  - Danger: low
- Deer hunting
  - Outcome: 🍎 Food
  - Yield: high
  - Variability: high
  - Danger: medium
  - Requires: Javelin Rack 🏠 Building
- Gather branches
  - Outcome: 🌲 Wood
  - Yield: low
  - Variability: low
  - Danger: medium
- Cut small trees
  - Outcome: 🌲 Wood
  - Yield: medium
  - Variability: low
  - Danger: medium
  - Requires: Tool Shed 🏠 Building
- 🏠 Building Construction
  - Start or continue constructing a 🏠 Building
- 🏠 Building Destruction
  - Outcome: 🏠 Destroyed, part of its 🌲 Material
  - Done in one day
- 🏆 Tell NPCs what they should do
- 🏆 Organize vote to change a policy
- 🏆 Do a coup to force-change a policy
- 🏆 Motivational speech
  - Outcome: 🏆 Fame
  - Requires: 🏆 Fame
- 🔎 Scavenge the forest : random outcome, forest related
- 🔎 Scavenge the beach : random outcome, beach related
- 🔪 Attempt murder
  - Outcome: Dead 👤 Villager
- ...

## 🏠 Building construction

- Each building require a different amount of ⚡ Energy and 🌲 Material to be built
- All the 🌲 Wood Is consumed when the building is started, ⚡ Energy gets filled as player work on it
- It can take one or several days to complete (or never be completed)

## 🏠 Building upgrade

- All 🏠 Buildings can be upgraded to increase their benefits
- There is branching in the upgrade, specializing the benefits
- Upgrading mechanism is the same as building
- 🏠 Building remain fully functional during upgrades

## 🏠 Buildings available

Some 🏠 Buildings have requirement to be doable, not visible until then

- Toolshed
  - 👤 Villagers user less ⚡ Energy to build 🏠 Buildings
  - 👤 Villagers user less ⚡ Energy to destroy 🏠 Buildings
  - 👤 Villagers user less ⚡ Energy to cut 🌲 Wood
- Javelin rack
  - 👤 Villagers user less ⚡ Energy to hunt food
- Boat
  - Allow 💪 Actions done on water
- Altar
  - Allow to sacrifice a 👤 Villager for 🏆 Fame
- ...

## 📑 Policies

Policies affect everybody, players can't break policies with their 💪 Action

- 🍎 Food sources : Omnivore, Vegetarian, Piscivore, Cannibal
- 🍎 Food consumption : All you can eat, reduced food (replenish 50% ⚡ Energy max), fasting
- ✅ Decision mode : Democratic Majority, Democratic weighted random, Authoritarian, Random
- ...

## 🎲 Events available

- Some 🎲 Events have conditions to be able to happen
- Events have a weighted chance to happen
- Max 1 event per day
- ...

## 👤 Villager 🔥 Modifiers

- hyper focus : reduce the 💪 Action difficulty, increase the 🍎 Food consumption
- chill out : increase the 💪 Action difficulty, decrease the 🍎 Food consumption
- work more : increase ⚡ Energy for the day, consume more 🍎 Food (diminishing returns)
- sick : chance to die, chance to contaminate, less energy
- ...

## 🏆 Fame mechanics

- NPCs will proportionally follow the top 3 👤 Villagers with most 🏆 Fame
- ...

## Milestones

- Research game design references
  - Board collaborative survival games
  - Board social games (Werewolf...)
- Option A: MVP Horizontal slice => test earlier
  - Game design the whole game coarsely
  - Implement the most basic collaborative survival part
  - Test and iterate until it's interesting
  - Add the event layer
  - Add the policies and decisions layer
  - Add the Fame layer
  - Add the Modifiers layer
- Option B: MVP Vertical slice
  - Have a bit of each layer with very few options
