include .env

create_migration:
	@read -p "Enter the sequence name: " SEQ; \
		migrate create -ext=sql -dir=./migrations -seq $${SEQ}

migrate_up:
	migrate -path=./migrations -database "${DATABASE_DSN}" -verbose up

migrate_down:
	@read -p "Number of migrations you want to rollback (default: 1): " NUM; NUM=$${NUM:-1}; \
		migrate -path=./migrations -database "${DATABASE_DSN}" -verbose down $${NUM}

force_migrate_up:
	@read -p "Enter the version to force migrate up: " VERSION; \
		read -p "Are you sure you want to force migrate up to version $${VERSION}? (yes/no): " CONFIRM; \
		if [ $${CONFIRM} = "yes" ]; then \
			migrate -path=./migrations -database "${DATABASE_DSN}" -verbose force $${VERSION}; \
		else \
			echo "Migration aborted."; \
		fi

.PHONY: create_migration migrate_up migrate_down force_migrate_up