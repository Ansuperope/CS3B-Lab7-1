# CS3B-Template
basic template for CS3b / Machine Language


1st Run Program:
1. Open Docker on desktop
2. ```docker compose up -d --build``` builds container, only need to do it once
3. ```docker compose exec arm64-dev bash``` runs program
If successful will see something like: ```root@c7b4b36e0052:/workspace#```

Exit Docker:
```exit```

Run after already building container:
1. Open Docker on desktop
2. ```docker compose exec arm64-dev bash```

Change Folder Name:
```mv CS3B-Template NEW_NAME```

Change main.s Name:
```mv main.s  NEW_NAME.S```

Change Makefile:
```main``` change to new file name
