---
--- Load data into database, this sql file is intended to be run after
--- the creation of the schemas, sql file.
---

--- Load upload milestones
INSERT INTO upload.milestone ( name, milestone_order ) VALUES ('SCHEDULED', 1);
INSERT INTO upload.milestone ( name, milestone_order ) VALUES ('INITIATED', 2);
INSERT INTO upload.milestone ( name, milestone_order ) VALUES ('UPDATED XT', 3);
INSERT INTO upload.milestone ( name, milestone_order ) VALUES ('UPDATED WEB', 4);
INSERT INTO upload.milestone ( name, milestone_order ) VALUES ('UPDATED PRODUCT SERVICE', 5);
INSERT INTO upload.milestone ( name, milestone_order ) VALUES ('NOTIFIED FULCRUM', 6);
INSERT INTO upload.milestone ( name, milestone_order ) VALUES ('INITIATED WHATSNEW', 7);
INSERT INTO upload.milestone ( name, milestone_order ) VALUES ('COMPLETED', 8);

--- Load stage events

-- Send doupload job from fulcrum to xt
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'UPDATED XT'),
        'Sent doupload to XT',
        'SENT_DOUPLOAD_TO_XT',
        1,
        50,
        't'
);

-- Receive doupload job by xt
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'UPDATED XT'),
        'Received doupload',
        'RECEIVED_DOUPLOAD',
        2,
        100,
        't'
);

-- Send pidupdate job from fulcrum to xt
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'UPDATED WEB'),
        'Sent pidupdate to WebDB',
        'SENT_PIDUPDATE_TO_WEBDB',
        1,
        100,
        't'
);

-- Send update to product service
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'UPDATED PRODUCT SERVICE'),
        'Sent product service update',
        'SENT_PRODUCT_SERVICE_UPDATE',
        1,
        100,
        't'
);

-- Received update by product service
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'UPDATED PRODUCT SERVICE'),
        'Received product service update',
        'RECEIVED_PRODUCT_SERVICE_UPDATE',
        2,
        100,
        'f'
);

-- Sent upload status from xt to fulcrum
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'NOTIFIED FULCRUM'),
        'Sent upload status to Fulcrum',
        'SENT_UPLOAD_STATUS',
        1,
        50,
        't'
);

-- Received upload status from xt to fulcrum
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'NOTIFIED FULCRUM'),
        'Received upload status',
        'RECEIVED_UPLOAD_STATUS',
        2,
        100,
        't'
);

-- Sent WhatsNew job
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'INITIATED WHATSNEW'),
        'Sent whatsnew update',
        'SENT_WHATSNEW_UPDATE',
        1,
        100,
        't'
);

-- Received WhatsNew job
INSERT INTO upload.stage ( upload_milestone_id, name, token, stage_order, completion_percentage, available )
    VALUES (
        (SELECT id FROM upload.milestone WHERE name = 'INITIATED WHATSNEW'),
        'Received whatsnew update',
        'RECEIVED_WHATSNEW_UPDATE',
        2,
        100,
        'f'
);
