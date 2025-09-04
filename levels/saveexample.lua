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
		battles="turnbased" -- can be turnbased, gridbased, or realtime
	},
	data={
		-- outer layer is x position, inner layer is y position
		{{{type="Box", id=1, status=1}}, {}, {}},
		{{}, {}, {}},
		{{}, {}, {{type="Switch", id=1}}}
	}
}

return dat