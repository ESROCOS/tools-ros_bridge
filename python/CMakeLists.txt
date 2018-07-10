# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

# Install source Python and JSON files
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/rosBridgeModule
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/python
)


install(
    FILES create_ros_bridge
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
)
