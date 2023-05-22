import os
import xml.etree.ElementTree as ET
maps_local_folder_path = "compose/maps/Campaigns"
match_settings_folder_path = "compose/maps/MatchSettings"

def create_or_update_xml_file(folder_path):
    folder_name_lower = os.path.basename(folder_path).lower()
    folder_name = os.path.basename(folder_path)
    xml_file_path = os.path.join(match_settings_folder_path, f"{folder_name_lower}.xml").replace("\\", "/")

    # Check if the XML file already exists
    if os.path.exists(xml_file_path):
        # Load the existing XML file
        print(f"Le fichier {folder_name_lower}.xml existe et va être modifié.")
        tree = ET.parse(xml_file_path)
        root = tree.getroot()
        map_elements = root.findall("map")
        for map_element in map_elements:
            root.remove(map_element)
    else:
      print(f"Le fichier {folder_name_lower}.xml n'existe pas, il a été créé avec des valeurs par défaut")
      root = ET.Element("playlist")
      gameinfos = ET.SubElement(root, "gameinfos")
      game_mode = ET.SubElement(gameinfos, "game_mode")
      game_mode.text = "0"
      script_name = ET.SubElement(gameinfos, "script_name")
      script_name.text = "Trackmania/TM_TimeAttack_Online"

      mode_script_settings = ET.SubElement(root, "mode_script_settings")
      setting = ET.SubElement(mode_script_settings, "setting")
      setting.set("name", "S_TimeLimit")
      setting.set("type", "integer")
      setting.set("value", "3600")

      startindex = ET.SubElement(root, "startindex")
      startindex.text = "0"

    # Iterate through the maps in the folder and add them to the playlist
    for src, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith(".Gbx"):
                map_name = file if " " not in file else f"'{file}'"
                map_path = os.path.join("Campaigns/",folder_name, map_name).replace("\\", "/")
                map_element = ET.SubElement(root, "map")
                map_file = ET.SubElement(map_element, "file")
                map_file.text = map_path

    tree = ET.ElementTree(root)
    tree.write(xml_file_path, encoding="utf-8", xml_declaration=True)

for root, dirs, files in os.walk(maps_local_folder_path):
  for dir in dirs:
    create_or_update_xml_file(os.path.join(root, dir).replace("\\", "/"))