# 2025-07-03T10:44:33.285357100
import vitis

client = vitis.create_client()
client.set_workspace(path="ONN_Final_Implementation")

advanced_options = client.create_advanced_options_dict(dt_overlay="0")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../design_2_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",generate_dtb = False,advanced_options = advanced_options,compiler = "gcc")

platform = client.get_component(name="platform")
domain = platform.get_domain(name="zynq_fsbl")

status = domain.regenerate()

comp = client.create_app_component(name="Hello_Final",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_ps7_cortexa9_0")

status = platform.build()

vitis.dispose()

