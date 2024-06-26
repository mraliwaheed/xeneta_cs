import os
import subprocess
import shutil
from datetime import datetime

def run_dbt_command(command):
    """
    Run a dbt commands
    """
    try:
        result = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Command Output:\n", result.stdout.decode())
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {e}")
        print("Command Output:\n", e.stdout.decode())
        print("Command Error:\n", e.stderr.decode())
        return False
    return True

def main():
    # Directrs for moving files
    source_dir = r'C:\Users\ZZ00OL808\xeneta_cs\data\files_to_load\input_files'
    destination_root_dir = r'C:\Users\ZZ00OL808\xeneta_cs\data\files_to_load\input_files\loaded'

    # Create a new directryt with date
    current_date = datetime.now().strftime('%Y-%m-%d')
    destination_dir = os.path.join(destination_root_dir, current_date)
    os.makedirs(destination_dir, exist_ok=True)

    # dbt models 
    dbt_commands = [
        "dbt run --models raw",
        "dbt run --models staging",
        "dbt run --models final"
    ]

    # Run the dbt commands
    for dbt_command in dbt_commands:
        print(f"Running: {dbt_command}")
        if not run_dbt_command(dbt_command):
            print("Aborting further execution due to error.")
            return

    # Copy files for ref
    for filename in os.listdir(source_dir):
        if filename.startswith('DE_casestudy_'):
            source_file = os.path.join(source_dir, filename)
            destination_file = os.path.join(destination_dir, filename)
            shutil.copy(source_file, destination_file)
            print(f'Done: {source_file} -> {destination_file}')

    print('All files have been moved.')

if __name__ == "__main__":
    main()

