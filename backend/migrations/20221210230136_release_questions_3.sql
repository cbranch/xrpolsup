ALTER TABLE release ADD COLUMN "fixedPenaltyFine" text NOT NULL DEFAULT '';
ALTER TABLE release ADD COLUMN "askedForDoctor" boolean NOT NULL DEFAULT FALSE;
ALTER TABLE release ADD COLUMN "seenByDoctor" boolean NOT NULL DEFAULT FALSE;
ALTER TABLE release ADD COLUMN "askedForMedication" boolean NOT NULL DEFAULT FALSE;
ALTER TABLE release ADD COLUMN "givenMedication" boolean NOT NULL DEFAULT FALSE;