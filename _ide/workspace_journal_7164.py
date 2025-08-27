# 2025-08-24T16:02:35.226183
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_Final_Implementation")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="Hello_Final")
comp.build()

vitis.dispose()

