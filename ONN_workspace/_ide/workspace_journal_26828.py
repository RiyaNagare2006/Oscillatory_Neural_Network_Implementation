# 2025-07-08T13:34:07.285742800
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

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

comp = client.get_component(name="app")
status = comp.import_files(from_loc="$COMPONENT_LOCATION/../../../Downloads", files=["vl53l0x.c"], dest_dir_in_cmp = "src")

status = platform.build()

comp = client.get_component(name="platform")
status = comp.import_files(from_loc="$COMPONENT_LOCATION/../../../Downloads", files=["vl53l0x.h"], dest_dir_in_cmp = "include")

status = platform.build()

status = platform.build()

comp = client.get_component(name="app")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

