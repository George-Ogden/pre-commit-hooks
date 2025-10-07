f = dict(a=1)

list_of_dicts = [
    dict(a=3, b=4),
    dict(hook_mask=3),
    dict(**f, g=3, **dict(a=4, d=4)),
    dict(
        multiline=True,
    )
]
