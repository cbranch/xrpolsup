ALTER TABLE release ADD COLUMN "askedToContactSCALP" boolean NOT NULL DEFAULT FALSE;
ALTER TABLE release ADD COLUMN "contactRefusalReason" text NOT NULL DEFAULT '';
ALTER TABLE release ADD COLUMN "otherComments" text NOT NULL DEFAULT '';