dat = {
	meta={
		name="Puzzle Parlor 1",
		desc="A fresh scoop of some of my finest puzzles yet. Take that corner of your brain you haven't used in a while on a little jog~!",
		color="green",
		version=1,
		diff=6,
		unix=1756336606,
		author={
			name="Rósaeolas",
			id="cinderspl"
		}
	},
	settings={
		theme="Rósa's Rolling Hills",
<<<<<<< HEAD
		track = "Meditation."
	},
	data={
		-- outer layer is x position, inner layer is y position
		startpos = {4, 4},
		map={
			{{{type="Box", id=1, status=1}}, 0, 0},
			{0, 0, 0},
			{0, 0, {{type="Switch", id=1}}, 0, {{type="Sign", text="You can probably imagine how much fun I'm having making this~"}}}
		}
=======
		battles="turnbased" -- can be turnbased, gridbased, or realtime
	},
	data={
		-- outer layer is x position, inner layer is y position
		{{{type="Box", id=1, status=1}}, {}, {}},
		{{}, {}, {}},
		{{}, {}, {{type="Switch", id=1}}}
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
	}
}

return dat