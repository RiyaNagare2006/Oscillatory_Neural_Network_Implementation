# 2025-07-10T01:10:41.721783
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_workspace")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="app")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

