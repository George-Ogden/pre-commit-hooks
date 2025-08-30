import mypy.plugin

class DummyPlugin(mypy.plugin.Plugin):...

def plugin(version) -> type[mypy.plugin.Plugin]:
    assert version == "1.16.1"
    return DummyPlugin
