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
		theme="Hills",
		track = "Ascension!"
	},
	data={
		-- outer layer is x position, inner layer is y position
		startpos = {4, 4},
		map={
			{0, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, {type="Wall"}, 0},
			{{type="Wall"}, 0, {type="Water", direction="down"}, {type="Water", direction="down"}, {type="Water", direction="down"}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{{type="Wall"}, {type="Wall"}, 0, 0, {type="Sign", text="You can probably imagine how much fun I'm having making this~"}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, {type="Water", direction="down"}, {type="Water", direction="left"}, {type="Water", direction="left"}, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, {type="Water", direction="down"}, {type="Wall"}, {type="Water", direction="up"}, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, {type="Water", direction="right"}, {type="Water", direction="right"}, {type="Water", direction="up"}, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{{type="Wall"}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
		}
	}
}

return dat