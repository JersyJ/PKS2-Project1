# Welcome to PKS-Project2


## Assignment

* Using the RRDTool tool to render status and network information into graphs. 
* The output will be at least 3 graphs - hourly, daily and weekly. 
* Installation of a web portal with functional graphs that will be the output of RRDTool. 
* For each project, the literature and internet resources used will be listed.
* The evaluation will take into account the complexity of the problem addressed and the formality of the project.

## Project layout

    mkdocs.yml    # The configuration file.
    project1/
        index.md                    # Homepage.
        incoming_packets.md         # Graphs of incoming packets.
        incoming_packets_total.md   # Graphs of total incoming packets.
        dev/
            setup_snmp.md           # Documentation for setting up SNMP.
            create_rr_database.md   # Documentation for creating a round-robin db.
            ingest_script.md        # Documentation for creating a script.
            setup_timer.md          # Documentation for setting up a timer.
            setup_nginx.md          # Documentation for setting up Nginx.
