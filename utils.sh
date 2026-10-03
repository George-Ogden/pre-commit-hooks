#!/usr/bin/env bash

cleanup_grep_output() {
	sed 's/\([[:digit:]]*:\)[[:space:]]*/\1 /'
}

neat_pattern_search() {
	local pattern="$1"
	rg -n "$pattern" "${file:?}" | cleanup_grep_output >"$LOG"
}

neat_word_search() {
	local word="$1"
	rg -nwi "$word" "${file:?}" | cleanup_grep_output >"$LOG"
}
