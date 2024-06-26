import subprocess

def run_dbt_command(command):
    """
    Run a dbt command using subprocess and handle errors.
    """
    try:
        result = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Command Output:\n", result.stdout.decode())
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {e}")
        print("Command Output:\n", e.stdout.decode())
        print("Command Error:\n", e.stderr.decode())
        raise

def main():
    # Set up the dbt command to run the models in the raw schema
    dbt_command = "dbt run --models raw"
    
    # Run the dbt command
    run_dbt_command(dbt_command)

if __name__ == "__main__":
    main()
