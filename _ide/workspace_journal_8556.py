# 2025-07-02T22:38:16.592534800
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_Final_Implementation")

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../design_1_wrapper.xsa")

status = platform.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../design_1_wrapper.xsa")

status = platform.build()

status = platform.build()

comp = client.get_component(name="Final")
comp.build()

