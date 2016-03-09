rubotest:
	rubocop -D -c rubocop.yml

rubofix:
	rubocop -D -a -c rubocop.yml

kitchenconverge:
	kitchen converge

foodtest:
	foodcritic .

travisci: rubotest foodtest

test: rubotest foodtest kitchenconverge
