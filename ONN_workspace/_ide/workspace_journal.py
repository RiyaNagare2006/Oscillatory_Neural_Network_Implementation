# 2025-09-06T19:23:05.612093500
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_workspace")

vitis.dispose()

