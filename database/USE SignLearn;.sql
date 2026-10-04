USE SignLearn;
GO

CREATE TABLE SignLanguageLessons (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    VideoUrl NVARCHAR(500),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE SignLanguageWords (
    Id INT PRIMARY KEY IDENTITY(1,1),
    LessonId INT NOT NULL,
    Word NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    VideoUrl NVARCHAR(500),

    CONSTRAINT FK_SignLanguageWords_Lesson
        FOREIGN KEY (LessonId)
        REFERENCES SignLanguageLessons(Id)
);
GO

CREATE TABLE UserProgress (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    LessonId INT NOT NULL,
    Completed BIT NOT NULL DEFAULT 0,
    CompletedAt DATETIME2 NULL,

    CONSTRAINT FK_UserProgress_User
        FOREIGN KEY (UserId)
        REFERENCES Users(Id),

    CONSTRAINT FK_UserProgress_Lesson
        FOREIGN KEY (LessonId)
        REFERENCES SignLanguageLessons(Id),

    CONSTRAINT UQ_UserProgress_UserLesson
        UNIQUE (UserId, LessonId)
);
GO

CREATE TABLE ChatRooms (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    CreatedBy INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_ChatRooms_CreatedBy
        FOREIGN KEY (CreatedBy)
        REFERENCES Users(Id)
);
GO

CREATE TABLE ChatRoomMembers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    RoomId INT NOT NULL,
    UserId INT NOT NULL,
    JoinedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_ChatRoomMembers_Room
        FOREIGN KEY (RoomId)
        REFERENCES ChatRooms(Id),

    CONSTRAINT FK_ChatRoomMembers_User
        FOREIGN KEY (UserId)
        REFERENCES Users(Id),

    CONSTRAINT UQ_ChatRoomMembers_RoomUser
        UNIQUE (RoomId, UserId)
);
GO
SELECT 
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;