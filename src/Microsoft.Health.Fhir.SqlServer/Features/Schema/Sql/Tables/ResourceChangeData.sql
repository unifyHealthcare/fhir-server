﻿/* Partitioned table that stores resource change information. */
CREATE TABLE dbo.ResourceChangeData 
(
    Id bigint IDENTITY(1,1) NOT NULL,
    Timestamp datetime2(7) NOT NULL CONSTRAINT DF_ResourceChangeData_Timestamp DEFAULT sysutcdatetime(),
    ResourceId varchar(64) NOT NULL,
    ResourceTypeId smallint NOT NULL,
    ResourceVersion int NOT NULL,
    ResourceChangeTypeId tinyint NOT NULL,
    PartitionDatetime datetime2(7) NOT NULL CONSTRAINT DF_ResourceChangeData_PartitionDatetime DEFAULT (DATEADD(HOUR,DATEDIFF(HOUR,0,SYSUTCDATETIME()),0))
) ON PartitionScheme_ResourceChangeData_Timestamp(PartitionDatetime);

CREATE CLUSTERED INDEX IXC_ResourceChangeData ON dbo.ResourceChangeData
    (Id ASC) WITH(ONLINE = ON) ON PartitionScheme_ResourceChangeData_Timestamp(PartitionDatetime);
