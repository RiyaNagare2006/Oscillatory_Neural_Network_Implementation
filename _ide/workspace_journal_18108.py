# 2025-07-03T08:11:41.724180400
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

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../design_1_wrapper.xsa")

domain = platform.get_domain(name="standalone_ps7_cortexa9_0")

status = domain.regenerate()

status = domain.set_lib(lib_name="xilskey", path="E:\riyan\2025.1\Vitis\data\embeddedsw\lib\sw_services\xilskey_v7_7")

status = domain.set_lib(lib_name="xilrsa", path="E:\riyan\2025.1\Vitis\data\embeddedsw\lib\sw_services\xilrsa_v1_8")

status = domain.set_lib(lib_name="xilflash", path="E:\riyan\2025.1\Vitis\data\embeddedsw\lib\sw_services\xilflash_v4_12")

status = domain.set_lib(lib_name="xilffs", path="E:\riyan\2025.1\Vitis\data\embeddedsw\lib\sw_services\xilffs_v5_4")

status = domain.set_lib(lib_name="lwip220", path="E:\riyan\2025.1\Vitis\data\embeddedsw\ThirdParty\sw_services\lwip220_v1_2")

status = domain.regenerate()

client.delete_component(name="platform")

vitis.dispose()

