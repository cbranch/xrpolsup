ALTER TABLE release ADD COLUMN "interviewedByPolice" boolean NOT NULL DEFAULT FALSE;
ALTER TABLE release ADD COLUMN "spokeToSolicitor" text NOT NULL DEFAULT '';