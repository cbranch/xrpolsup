ALTER TABLE report ADD COLUMN "policeCallTime" timestamp with time zone;
ALTER TABLE report ADD COLUMN "custodyNumber" text;
ALTER TABLE report ADD COLUMN "court" text;
ALTER TABLE report ADD COLUMN "releasedTime" timestamp with time zone;