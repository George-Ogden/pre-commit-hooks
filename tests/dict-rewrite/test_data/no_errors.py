f = dict(a=1)

list_of_dicts = [
    dict(a=3, b=4),
    {1: 3, "c": 4},
    dict(),
    {},
    {**f, **{}},
    {"book mark": 3},
    {**f, **{"1": 3}, "2blah": 4},
]
