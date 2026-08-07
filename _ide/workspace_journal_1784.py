# 2025-11-04T17:37:53.096460300
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_Final_Implementation")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="Hello_Final")
comp.build()

status = platform.build()

comp.build()

vitis.dispose()

