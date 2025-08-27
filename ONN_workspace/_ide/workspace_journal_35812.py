# 2025-07-08T14:58:17.171831500
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

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

