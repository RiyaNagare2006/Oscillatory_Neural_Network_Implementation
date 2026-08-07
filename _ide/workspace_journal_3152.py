# 2025-11-06T11:34:32.398676600
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_Final_Implementation")

platform = client.get_component(name="platform")
status = platform.build()

status = platform.build()

comp = client.get_component(name="Hello_Final")
comp.build()

vitis.dispose()

