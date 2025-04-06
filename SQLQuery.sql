USE CNPM_DB;
GO

CREATE TABLE [User] (
    UserID NVARCHAR(50) PRIMARY KEY NOT NULL,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
	Sex BIT,
	DateOfBirth DATETIME,
    CreateAt DATETIME,
	UserName NVARCHAR(100),
    [Password] NVARCHAR(100),
    [Role] NVARCHAR(20),
);

CREATE TABLE Course (
    CourseID NVARCHAR(50) PRIMARY KEY NOT NULL,
    CourseName NVARCHAR(100),
    Price FLOAT,
    [Description] NVARCHAR(MAX),
    TotalLessons INT,
	AverageRating FLOAT
);

CREATE TABLE Lesson (
    LessonID NVARCHAR(50) PRIMARY KEY NOT NULL,
    LessonName NVARCHAR(100),
    [Order] INT,
    [Description] NVARCHAR(MAX),
    Duration NVARCHAR(100),
	URLVideo NVARCHAR(MAX),
    CourseID NVARCHAR(50) NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Enrollment (
    EnrollmentID NVARCHAR(50) PRIMARY KEY NOT NULL,
    UserID NVARCHAR(50) NOT NULL,
    CourseID NVARCHAR(50) NOT NULL,
    Progress NVARCHAR(100),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Review (
    ReviewID NVARCHAR(50) PRIMARY KEY NOT NULL,
    Rating INT,
    Comment NVARCHAR(MAX),
    CreatedAt DATETIME,
	UserID NVARCHAR(50) NOT NULL,
    CourseID NVARCHAR(50) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
	FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Bill (
    BillID NVARCHAR(50) PRIMARY KEY NOT NULL,
    CreatedAt DATETIME,
    StatusPayment BIT,
	EnrollmentID NVARCHAR(50) NOT NULL,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollment(EnrollmentID)
);

INSERT INTO [User] (UserID, FullName, Email, Sex, DateOfBirth, CreateAt, UserName, [Password], [Role]) VALUES
('U0001', N'Phạm Công Đức', 'admin1@gmail.com', 1, '1990-01-01', GETDATE(), 'ducne', 'duc123', 'adminuser'),
('U0002', N'Đặng Thị Ngọc Thảo', 'admin2@gmail.com', 0, '1992-02-02', GETDATE(), 'thaone', 'thao123', 'admincontent'),
('U0003', N'Nguyễn Văn An', 'student1@gmail.com', 1, '2000-03-03', GETDATE(), 'anne', 'an123', 'student'),
('U0004', N'Phạm Thị Thu', 'student2@gmail.com', 0, '2001-04-04', GETDATE(), 'phamminhthu', 'thupham09', 'student'),
('U0005', N'Hoàng Văn Nhật', 'student3@gmail.com', 1, '2002-05-05', GETDATE(), 'nhathoang', 'hoang12', 'student'),
('U0006', N'Ngô Thị Mẫn', 'student4@gmail.com', 0, '2000-06-06', GETDATE(), 'ngothiman', 'ngothiman...', 'student'),
('U0007', N'Lê Khánh Nguyên', 'student5@gmail.com', 1, '2001-07-07', GETDATE(), 'nguyenne', 'nguyen123', 'student'),
('U0008', N'Đỗ Thị Hà', 'student6@gmail.com', 0, '2002-08-08', GETDATE(), 'hado123', 'cnpm!!', 'student'),
('U0009', N'Hồ Văn Kiên', 'student7@gmail.com', 1, '2000-09-09', GETDATE(), 'kiendo', 'kienkien', 'student'),
('U0010', N'Bùi Thị Thu', 'student8@gmail.com', 0, '2001-10-10', GETDATE(), 'buitthu', 'thu8976', 'student');


INSERT INTO Course (CourseID, CourseName, Price, [Description], TotalLessons, AverageRating) VALUES
('C0001', N'Lập trình C++ cơ bản', 499000, N'Khóa học nhập môn C++', 5, 4.5),
('C0002', N'Python cho người mới', 599000, N'Học Python từ đầu', 5, 4.7),
('C0003', N'HTML & CSS cơ bản', 399000, N'Thiết kế web cơ bản', 5, 4.2),
('C0004', N'Java OOP nâng cao', 699000, N'Chuyên sâu lập trình Java', 5, 4.6),
('C0005', N'C# Winform', 499000, N'Ứng dụng Windows bằng C#', 5, 4.3),
('C0006', N'MySQL cho người mới', 449000, N'Quản lý cơ sở dữ liệu MySQL', 5, 4.1),
('C0007', N'JavaScript căn bản', 479000, N'Lập trình JS đơn giản', 5, 4.4),
('C0008', N'NodeJS cơ bản', 589000, N'Lập trình backend bằng NodeJS', 5, 4.2),
('C0009', N'ReactJS toàn tập', 699000, N'Frontend với ReactJS', 5, 4.8),
('C0010', N'Machine Learning nhập môn', 799000, N'Học máy cho người bắt đầu', 5, 4.9);

-- Mẫu tạo 5 bài học cho mỗi Course
DECLARE @course INT = 1;
WHILE @course <= 10
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= 5
    BEGIN
        DECLARE @lessonID NVARCHAR(10) = 'L' + RIGHT('000' + CAST((@course - 1) * 5 + @i AS NVARCHAR), 4);
        INSERT INTO Lesson (LessonID, LessonName, [Order], [Description], Duration, URLVideo, CourseID)
        VALUES (@lessonID, N'Bài ' + CAST(@i AS NVARCHAR) + N' của khóa ' + CAST(@course AS NVARCHAR), @i, N'Nội dung bài học', '30 phút', 'http://video.com/sample', 'C' + RIGHT('000' + CAST(@course AS NVARCHAR), 4));
        SET @i += 1;
    END
    SET @course += 1;
END


INSERT INTO Enrollment (EnrollmentID, UserID, CourseID, Progress) VALUES
('E0001', 'U0003', 'C0001', '20%'),
('E0002', 'U0004', 'C0002', '35%'),
('E0003', 'U0005', 'C0003', '40%'),
('E0004', 'U0006', 'C0004', '10%'),
('E0005', 'U0007', 'C0005', '50%'),
('E0006', 'U0008', 'C0006', '25%'),
('E0007', 'U0009', 'C0007', '60%'),
('E0008', 'U0010', 'C0008', '15%'),
('E0009', 'U0003', 'C0009', '70%'),
('E0010', 'U0004', 'C0010', '30%');


INSERT INTO Bill (BillID, CreatedAt, StatusPayment, EnrollmentID) VALUES
('B0001', GETDATE(), 1, 'E0001'),
('B0002', GETDATE(), 1, 'E0002'),
('B0003', GETDATE(), 1, 'E0003'),
('B0004', GETDATE(), 1, 'E0004'),
('B0005', GETDATE(), 0, 'E0005'),
('B0006', GETDATE(), 1, 'E0006'),
('B0007', GETDATE(), 1, 'E0007'),
('B0008', GETDATE(), 0, 'E0008'),
('B0009', GETDATE(), 1, 'E0009'),
('B0010', GETDATE(), 1, 'E0010');


INSERT INTO Review (ReviewID, Rating, Comment, CreatedAt, UserID, CourseID) VALUES
('R0001', 5, N'Khóa học rất hay', GETDATE(), 'U0003', 'C0001'),
('R0002', 4, N'Nội dung ổn', GETDATE(), 'U0004', 'C0002'),
('R0003', 5, N'Thầy dạy dễ hiểu', GETDATE(), 'U0005', 'C0003'),
('R0004', 3, N'Có thể cải thiện phần lý thuyết', GETDATE(), 'U0006', 'C0004'),
('R0005', 5, N'Rất đáng học', GETDATE(), 'U0007', 'C0005'),
('R0006', 4, N'Bài tập hữu ích', GETDATE(), 'U0008', 'C0006'),
('R0007', 4, N'Học được nhiều kiến thức mới', GETDATE(), 'U0009', 'C0007'),
('R0008', 5, N'Quá tuyệt vời', GETDATE(), 'U0010', 'C0008'),
('R0009', 5, N'Khóa học đáng tiền', GETDATE(), 'U0003', 'C0009'),
('R0010', 4, N'Hay nhưng hơi nhanh', GETDATE(), 'U0004', 'C0010'),
('R0011', 3, N'Chưa đầy đủ ví dụ', GETDATE(), 'U0005', 'C0001'),
('R0012', 5, N'Cực kỳ chi tiết', GETDATE(), 'U0006', 'C0002'),
('R0013', 5, N'Tốt nhất mình từng học', GETDATE(), 'U0007', 'C0003'),
('R0014', 4, N'Cần thêm bài tập', GETDATE(), 'U0008', 'C0004'),
('R0015', 5, N'Thực hành rất thực tế', GETDATE(), 'U0009', 'C0005');




