# 2025-08-24T15:46:51.889034100
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_workspace")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="app")
comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../design_1_wrapper.xsa")

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../design_2_wrapper.xsa")

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../design_1_wrapper.xsa")

status = platform.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../design_1_wrapper.xsa")

status = platform.build()

vitis.dispose()

