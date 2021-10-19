
ALTER TABLE report ADD COLUMN "concernMinorUnderSixteen" BOOLEAN;
ALTER TABLE report DROP COLUMN "isHS2Action";
ALTER TABLE report ADD COLUMN "actionGroup" TEXT;
ALTER TABLE release ADD COLUMN "accusedOf" TEXT;
ALTER TABLE release ADD COLUMN "plea" TEXT;
ALTER TABLE release ADD COLUMN "furtherHearings" TEXT;
ALTER TABLE release ADD COLUMN "solicitor" TEXT;
ALTER TABLE release DROP COLUMN "rebelsStillHeld";
ALTER TABLE release DROP COLUMN "localXRGroup";
ALTER TABLE release ADD COLUMN "xrRegion" TEXT;
ALTER TABLE release DROP COLUMN "canShareWithLocalXRGroup";
ALTER TABLE release DROP COLUMN "canShareWithXRPress";
ALTER TABLE release DROP COLUMN "isHS2Action";
ALTER TABLE release DROP COLUMN "isPartOfXR";
ALTER TABLE release ADD COLUMN "actionGroup" TEXT;