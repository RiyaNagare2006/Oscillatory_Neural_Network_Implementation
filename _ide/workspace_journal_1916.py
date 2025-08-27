# 2025-07-04T09:25:10.734144200
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_Final_Implementation")

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../design_2_wrapper.xsa")

status = platform.build()

status = platform.build()

comp = client.get_component(name="Hello_Final")
comp.build()

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../design_2_wrapper.xsa")

status = platform.build()

status = platform.build()

comp.build()

vitis.dispose()

