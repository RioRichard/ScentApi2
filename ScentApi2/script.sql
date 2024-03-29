USE [master]
GO
/****** Object:  Database [Scent]    Script Date: 4/23/2022 8:29:03 PM ******/
CREATE DATABASE [Scent]
 
GO
USE [Scent]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[IDAccount] [varchar](64) NOT NULL,
	[UserName] [varchar](32) NULL,
	[Password] [varbinary](64) NULL,
	[Email] [varchar](64) NULL,
	[Token] [varchar](64) NULL,
	[ExpiredTokenTime] [datetime] NULL,
	[IsConfirmed] [bit] NULL,
	[IsDelete] [bit] NULL,
	[FullName] [nvarchar](64) NULL,
	[Gender] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountAddress]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountAddress](
	[IDAddress] [int] NOT NULL,
	[IDAccount] [varchar](64) NOT NULL,
	[IsDefault] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDAddress] ASC,
	[IDAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountStaff]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountStaff](
	[IDStaff] [varchar](64) NOT NULL,
	[UserName] [varchar](32) NULL,
	[Password] [varbinary](64) NULL,
	[Email] [nvarchar](64) NULL,
	[Token] [varchar](64) NULL,
	[ExpiredTokenTime] [datetime] NULL,
	[IsConfirmed] [bit] NULL,
	[IsDelete] [bit] NULL,
	[FullName] [nvarchar](64) NULL,
	[Gender] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDStaff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[IDAddress] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](64) NULL,
	[Phone] [varchar](12) NULL,
	[Reciever] [nvarchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[IDCart] [uniqueidentifier] NOT NULL,
	[IsExpired] [bit] NULL,
	[IDAccount] [varchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[IDCategory] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](64) NULL,
	[Isdelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[IDInvoice] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime] NULL,
	[DateExpired] [datetime] NULL,
	[IDCart] [uniqueidentifier] NOT NULL,
	[IDAddress] [int] NOT NULL,
	[IDStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDInvoice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[IDProduct] [int] IDENTITY(1,1) NOT NULL,
	[IDCategory] [int] NOT NULL,
	[Name] [nvarchar](128) NULL,
	[Price] [int] NULL,
	[Stock] [int] NULL,
	[ImageURL] [nvarchar](256) NULL,
	[IsDelete] [bit] NULL,
	[Description] [nvarchar](4000) NULL,
	[ShortDescription] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCart]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCart](
	[IDCart] [uniqueidentifier] NOT NULL,
	[IDProduct] [int] NOT NULL,
	[Quantity] [int] NULL,
	[PaymentPrice] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCart] ASC,
	[IDProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[IDRole] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[IsDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StaffRole]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffRole](
	[IDRole] [uniqueidentifier] NOT NULL,
	[IDStaff] [varchar](64) NOT NULL,
	[IsDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDRole] ASC,
	[IDStaff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 4/23/2022 8:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[IDStatus] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](64) NULL,
	[IsDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([IDCategory], [CategoryName], [Isdelete]) VALUES (1, N'Danh mục nước hoa 1', 0)
INSERT [dbo].[Category] ([IDCategory], [CategoryName], [Isdelete]) VALUES (2, N'Danh mục nước hoa 2', 0)
INSERT [dbo].[Category] ([IDCategory], [CategoryName], [Isdelete]) VALUES (3, N'Danh mục nước hoa 3', 0)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (1, 1, N'
Christian Louboutin Loubiluna Intense', 100000, 100, N'Christian-Louboutin-Loubiluna-Intense.jpg', 0, N'Christian Louboutin Loubiluna Intense là một mùi hương mạnh mẽ và phong phú, hoàn hảo với những buổi tiệc trước khi trời tối. Loubiluna chứa đầy những tông xạ hương như sữa sung và gỗ tuyết tùng, kết thúc trên nền giấy cói.Christian Louboutin Loubiluna Intense hóa thân một chú chim ưng hoàng gia tao nhã đứng trên vầng trăng khuyết ấn tượng. Mặt sau của chú chim ưng hoàng gia này có đế màu đỏ đặc trưng và được gắn vương miệng khắc logo thương hiệu.', N'Nhóm nước hoa: Hương Gỗ Phương Đông (Amber Woody)Năm ra mắt: 2022Giới Tính: UnisexNồng độ: Eau De Parfum (EDP)Phong cách: Thu Hút, Nổi Bật, Sang TrọngHương đầu: Sữa Sung
Hương giữa: Gỗ Tuyết Tùng, Xạ Hương
Hương cuối: Giấy Cói')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (2, 1, N'
Louis Vuitton City of stars', 100000, 100, N'louis-vuitton-city-of-stars-3.jpg', 0, N'Louis Vuitton City of stars là sáng tạo mùi hương thứ 6 của team Southern California trong bộ Collection vốn đã quá nổi tiếng trước đó. City Of Stars được coi là một mùi hương tiếp nối cho câu chuyện của California Dream, sau khi hoàng hôn buông xuống nơi bờ biển phía Tây nước Mỹ, thành phố Los Angeles mới thực sự lộ ra vẻ hoa lệ vốn có của nó &#8211; Một thành phố náo nhiệt không bao giờ ngủ.Bậc thầy nước hoa Jacques Cavallier Belletrud khắc hoạ Los Angeles trong một lễ hội vào ban đêm với sự sôi động và xa hoa qua Louis Vuitton City of Stars. Tại Los Angeles có những đại lộ đầy ánh đèn đến những chòm sao lung linh phía đường chân trời. Khi bóng đêm buông xuống, ánh sáng của thành phố bùng lên trong một hoạt cảnh khứu giác đầy gợi cảm.Louis Vuitton City of Stars xuất hiện với mùi hương từ cam quýt rực rỡ như hàng ngàn bóng đèn: chanh,quýt đỏ, cam bergamot nhảy múa, bên cạnh vẻ đẹp gợi cảm của hoa Tiaré. City of stars được sưởi ấm bởi gỗ đàn hương quý phái ám chỉ một niềm đam mê lan tỏa trong những tia nắng đầu tiên của buổi sáng. City of star của Louis Vuitton khiến cả vị giác, khứu giác và xúc giác như bùng nộ trong một đêm tiệc ở thành phố của các vì sao.', N'Nhóm Hương: Hương Phương ĐôngGiới tính: UnisexNăm ra mắt: 2022Nồng độ: Eau De ParfumNhà pha chế: Jacques Cavallier-BelletrudPhong cách: Hiện đại , Cuốn Hút, Năng ĐộngHương Đầu: Quả Chanh Xanh, Cam Đỏ, Quả Quýt, Quả Chanh Vàng, Cam BergamotHương Giữa: Hoa TiareHương Cuối: Xạ Hương, Phấn Hương, Gỗ Đàn Hương')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (3, 1, N'
Christian Louboutin Loubiprince', 100000, 100, N'z3350175971036_4b73d7620b73be47a5255dc47ed4cee1-min.jpg', 0, N'Christian Louboutin Loubiprince thuộc bộ sưu tập mới LoubiWorld được lấy cảm hứng từ những chuyến du lịch đến các quốc gia khác nhau mà Christian Louboutin đã đến thăm. Trong trường hợp này, tôi tưởng tượng một chuyến đi đến Ai Cập đầy nắng, lịch sử cổ đại, sa mạc oi bức và những kim tự tháp nổi tiếng.Thay vì chai đỏ tươi như trước, lần này nước hoa của Louboutin được đựng trong những chai đỏ thẫm, huyền bí hơn, hấp dẫn hơn bao giờ hết, thiết kế của chai rất quý phái và uy nghiêm, mang một nét quyến rũ đặc biệt vốn có của nước hoa Christian Louboutin. Christian Louboutin Loubiprince với Màu đỏ tía đậm sâu được bổ sung một cách hài hòa bởi nắp vàng tinh tế được thiết kế như một kim tự tháp uy nghi được bao bọc bởi một con rắn bí ẩn. Đầu của con rắn được tạo hình tinh tế giống như một chiếc giày cao gót mang tính biểu tượng của Louboutin.Christian Louboutin Loubiprince là hình ảnh thu nhỏ của sự sang trọng. Mùi hương mở ra với sự bùng nổ tươi mát của Cam Quýt tươi mới tiếp nối sau là các nốt hương của gỗ đàn hương và xạ hương đầy bí ẩn và thu hút. Cuối cùng là sự cuồng nhiệt nhưng lại đầy ma mị với sự xuất hiện của Đậu Tonka, Hổ Phách và Vanilla là lên sự ngọt ngào không thể chối từ.', N'Nhóm nước hoa: Hương Gỗ Phương Đông (Amber Woody)Năm ra mắt: 2022Giới Tính: UnisexNồng độ: Eau De Parfum (EDP)Phong cách: Nổi Bật, Tinh Tế, Sang TrọngHương đầu: Cam bergamot, Chanh.
Hương giữa: Gỗ Đàn Hương, Xạ hương, Bột
Hương cuối: Đậu Tonka, Hổ Phách, Vanilla')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (4, 1, N'
Narciso Rodriguez Fleur Musc Florale', 100000, 100, N'Narciso-Rodriguez-Fleur-Musc-Florale-1.jpg', 0, N'Narciso Rodriguez Fleur Musc Florale được ra  mắt vào năm 2020, với mục đích hoàn thiện vẻ đẹp cho  phái nữ trong bộ cánh màu hồng mang tên Fleur Musc.Là phiên bản Eau De Toilette, mùi hương của cô nàng mới này nhẹ nhàng và thanh mảnh hơn trong cách dẫn dắt lan tỏa sự ngọt ngào, gợi cảm vốn có của Hoa hồng và Xạ hương. Ở phiên bản gốc ra mắt vào năm 2017 là Eau De Parfum, việc các note hương Hoa hồng được nằm cạnh Hoa mẫu đơn mang lại sự sắc thái cuốn hút có phần khiêu khích và mạnh mẽ, thì ở phiên bản EDT này, hoa mẫu đơn đã không còn, mà thay vào đó là sự hiện diện của Cam bergamot ngay note hương đầu tiền, đóng vai trò làm giảm đột gắt của Hồng tiêu cũng như sự mạnh mẽ trong chặng cuối của hương gỗ khi Narciso Rodriguez Fleur Musc Florale nằm trên da sau chừng 30 phút.Có một điều làm nên sự khác biệt của cô nàng Narciso Rodriguez Fleur Musc Florale này đó chính là hương hoa hồng, Hoa hồng của cô nàng này là hoa hồng nở lúc sáng sớm, thời điểm giao thoa của sương mai cùng nhị hoa e ấp tỏa hương. Trong veo và nhẹ nhàng, là sự bình yên của một sớm mai dịu dàng và dễ chịu.Khi mặt trời ló rạng ở phía Đông, là lúc xạ hương vuốt ve làn tóc rối, thì thầm bởi sắc hương trong tâm trí của mùi gỗ nhẹ thoang thoảng quanh đây, một cái ôm bất ngờ và thật chặt từ phía sau chính là một ngày đẹp nhất mà cô nàng Narciso Rodriguez Fleur Musc Florale luôn được sở hữu', N'Nhóm nước hoa: Hương hoa cỏ sípNăm ra mắt: 2020Giới Tính: NữNồng độ: Eau De Toilette (EDT)Phong cách: Quyến Rũ, Nữ Tính, Gợi CảmHương đầu: Cam bergamot, Hồng tiêu
Hương giữa: Hoa hồng, Xạ hương
Hương cuối: Gỗ, Hoắc hương, Hổ phách')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (5, 1, N'
	
	Florabotanica Balenciaga
	', 100000, 100, N'Florabotanica-Balenciaga-4.jpg', 0, N'
									



Mình gọi nó là “Chai nước hoa mùa hè” Cái mùi gì mà ngòn ngọt mà thơm mát tự nhiên dễ chịu chứ không phải kiểu mùi ấn tượng nhưng khó đoán biết.


Florabotanica Balenciaga lột tả vẻ đẹp của những cành hồng nhung đỏ rực rỡ, những cành hồng đang trong độ đẹp nhất, tươi sáng nhất hé mở trong vườn thượng uyển, bên cạnh những khóm cây bạc hà xanh mát rười rượi.


Dưới cơn mưa rào của mùa thu, từng lá bạc hà hơi dập nát toát lên vị hăng nồng, the mát tột cùng. Những lá bạc hà quyện cùng cánh hồng nhung đẫm nước mưa ấy tạo thành một mùi hương khó mà quên được. Nó như hằn sâu trong kí ức những người yêu thiên nhiên một cách nhẹ nhàng và quyến rũ nhất. Càng về sau, mùi hồng dần dịu đi, nhường chỗ cho mùi xanh mát của cỏ cây, của đất trời, của không khí ẩm mát. Khu vườn như bừng sáng hơn với mùi cỏ vetiver xanh non mơn mởn và hoa cẩm chướng.



Florabotanica Balenciaga, sự thanh thoát lại nằm ở những ngọn cỏ xanh rì và hoa tạo nên nét cá tính, đầy gai góc ẩn sau sự nữ tính vốn có của top notes. Florabotanica hướng đến mọi cô gái, nhưng cá tính của Florabotanica thì ít cô gái nào có được: mạnh mẽ, cá tính, gai góc nhưng tất cả đều ẩn sau một vẻ đẹp NỮ TÍNH mỏng manh mà lại sắc lẹm ngọt ngào đầy NGUY HIỂM

							', N'
	Nhóm nước hoa: Hương Hoa Cỏ Tự Nhiên
Năm ra mắt: 2012
Giới Tính: Nữ
Nồng độ: Eau De Parfum (EDP)
Phong cách: Trẻ Trung, Cá Tính, Năng Động

Hương đầu: bạc hà
Hương giữa: hoa hồng, cẩm chướng, cần sa
Hương cuối: hổ phách, cỏ vetiver

')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (6, 1, N'
Dior Eau Sauvage', 100000, 100, N'Dior-Eau-Sauvage.jpg', 0, N'Dior Eau Sauvage &#8211; Mùi hương được kết hợp từ sự tươi mát từ vị cam quýt pha trộn với hoa oải hương cay và lớp hương cuối của gỗ đầy nam tính.Các âm sắc quyến rũ của rêu và sự xen lẫn của hương hoa nhài mang đến cho Dior Eau Sauvage khía cạnh tuyệt vời và vẻ bí ẩn của nó đã được giảm trong phiên bản hiện thời, cùng với hoa đinh hương làm cho lớp hương giữa trở nên ấm áp hơn. Ngày nay, nó trở nên gần giống với các loại nước hoa cam quýt cổ điển, và mang lại cảm giác ấm trên da. Tuy vậy, Dior Eau Sauvage là hương thơm lấy cảm hứng từ chi cam chanh được hoàn thiện một cách tuyệt vời, và mặc dù nó được sản xuất để dành cho nam giới nhưng phụ nữ cũng không thể cưỡng lại được sức hút của nó.Trong sáng và bướng bỉnh, Dior Eau Sauvage là nước hoa dành cho trường phái của sự thanh lịch, tinh tế, và những tâm hồn vui vẻ. Dù bao lần nó đã được chế tác lại, nhưng nó vẫn tươi mát, kín đáo và cổ điển.', N'Nhóm nước hoa: Hương Citrus AromaticNăm ra mắt: 2008Giới Tính: NamNồng độ: Eau De Toilette (EDT)Phong cách: Phóng Khoáng, Nam Tính, Cuốn HútHương đầu: cây hương thảo, cây carum, các loại trái cây, cây húng quế, cam Bergamot, chanhHương giữa: cây rau mùi, hoa cẩm chướng, gỗ đàn hương, hoắc hương, rễ cây oris, hoa nhài, hoa hồngHương cuối: hổ phách, xạ hương, địa y, cỏ Vetiver')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (7, 1, N'
	
	Mad Et Len Red Musc
	', 100000, 100, N'Mad-et-Len-Red-Musc-4.jpg', 0, N'
									


Vốn không màng đến những xu hướng khác nhau của thế giới , Mᴀᴅ Eᴛ Lᴇɴ luôn mang một cá tính riêng, bí ẩn tối tăm và vô cùng ấn tượng. Từ những món đồ decor trang trí, cho đến những chai nước hoa, những hộp nến thơm, lọ tinh dầu hay đá lava, đá hổ phách . . tất cả đều được làm hoàn toàn bằng tay bởi những người thợ thủ công tài ba và khéo léo.
Một điều khá thú vị là Mᴀᴅ Eᴛ Lᴇɴ luôn biết cách tận dụng những miếng kim loại cũ để chế tác, vậy nên bạn đừng ngạc nhiên khi cầm trên tay những sản phẩm cao cấp được bao bọc trong một lớp vỏ hộp bằng sắt cũ kĩ và gỉ sét nhưng lại mang một vẻ đẹp bí ẩn ma mị vô cùng độc đáo và nghệ thuật. Tất cả những sản phẩm mùi hương của Mᴀᴅ Eᴛ Lᴇɴ đều qua một quá trình chọn lọc nguyên liệu và chế tác thủ công cực kỳ kĩ lưỡng.

Có những sản phẩm phải mất đến 2 năm mới đạt tiêu chuẩn chất lượng để có thể đưa đến tay người sử dụng. Do đó những mùi hương của Mᴀᴅ Eᴛ Lᴇɴ chỉ được sản xuất mỗi lần với số lượng rất ít và rất khó để sở hữu. Nhưng khó khăn nào cũng có giá trị của nó, chắc chắn một điều bạn sẽ không bao giờ phải thất vọng khi sở hữu bất cứ mùi hương nào . .
Mã bán chạy nhất nhà Mᴀᴅ Eᴛ Lᴇɴ là Mad Et Len Red Musc: Hương xạ hương trắng + chút phấn + bột gỗ + trầm + Hổ Phách. Nếu ai đã lỡ mê AɴOᴛʜᴇʀ 13 của Lᴇ Lᴀʙᴏ sẽ không thể nào bỏ qua Mad Et Len Red Musc. Cùng style mùi nhưng hay hơn hẳn. Hổ phách tươi sáng, nhẹ nhàng, lấp lánh kéo từng dải xạ trắng mơn trớn nhảy múa trên da, hoà hợp với thân nhiệt bốc toả ra thứ mùi hương mlem mlem chẳng thể chối từ.
							', N'
	Nhóm nước hoa: Hương gỗ và xạ hương
Giới Tính: Unisex
Nồng độ: Eau De Parfum (EDP)
Phong cách: Lôi Cuốn, Sang Trọng, Tinh Tế

Hương Chính: Xạ Hương Trắng, Gỗ Trầm, Hổ Phách, Bột Phấn

')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (8, 1, N'
Masque Milano Russian Tea', 100000, 100, N'Masque-Milano-Russian-Tea.jpg', 0, N'Masque Milano Russian Tea là mùi hương được lấy ý tưởng từ những của tiệm cafe tại đại lộ Nevsky Prospekt của trung tâm thành phố St. Petersburg nước Nga. Đây được coi là chai nước hoa mang lại tên tuổi cho nhà Niche Masque Milano. Russian Tea không những nổi tiếng về mùi hương, mà còn ở sự hiếm có khó tìm của nó trên thị trường. Mất tích rất lâu, và Russian Tea chỉ mới xuất hiện lại gần đây với số lượng cực kỳ ít, đưa được mùi hương này về Việt Nam thực sự rất kì công, và chưa thể hứa hẹn đợt kế tiếp sẽ là khi nào.Nếu bạn cần tìm mùi trà nhẹ nhàng, thoang thoảng mùi hoa như những mùi trà bình thường thì hãy tìm ngay một mùi trà khác. Ở Masque Milano Russian Tea là một kiểu hương trà đặc biệt hơn nhiều. Thứ hương thơm vương vấn cả ngày dài sẽ làm bạn say nắng ngay lập tức.Trà của Nga khác hơn một chút ở chỗ họ có thêm chút quả và gia vị pha chung với trà. Masque Milano Russian Tea cũng như vậy. Ban đầu, hương bạc hà the mát dễ dàng đánh thức khứu giác, thêm vào một chút the the của tiêu đen, thoáng đâu một chút chua chua ngọt ngọt của raspberry. Người ta thấy Russian Tea sao mà đáng yêu, sao mà dễ chiều tới vậy.Nhưng hớp một ngụm trà rồi, người ta mới thấy đủ cái độ mạnh mà loại trà này mang lại. Masque Milano Russian Tea được pha chế từ trà đen – loại trà có mức độ cafein cao nhất và đậm đặc nhất. Xoay vần đâu đó, người ta có thể ngửi thấy hương hoa toát lên từ vị trà. Chỉ thoảng chút thôi, có mùi hương của hoa lan nhè nhẹ, quyện với chút hương ngọt của quả. Lúc này Russian Tea khá dễ uống, bạn sẽ chỉ thấy hơi say chút trà thơm, với chút hoa quả dịu dàng thôi.Lúc xuống note, Masque Milano Russian Tea mới làm cho bạn thấy ngạc nhiên. Nói là trà, nhưng mà lại có nốt hương leather (da thuộc). Hình như Masque Milano muốn miêu tả cả một quá trình làm ra tách trà này, thay vì chỉ để cho người ta ngửi thấy mùi hương cuối cùng trên bàn tiệc. Note da thuộc thực ra được lấy cảm hứng từ quá trình đun trà trong ấm Samovar. Người ta sử dụng một dụng cụ bịt phần khí thoát ra của Samovar làm bằng da thuộc, giúp quá trình lưu thông khí oxy trong khi đun sôi trà tốt hơn, cho hương vị khá đặc biệt. Thiệt tình, tôi cũng chưa bao giờ được thử đun trà theo kiểu người Nga, nhưng quả thật đến đây là hiểu vì sao Russian Tea lại có mùi da thuộc nồng ấm quyện với mùi trà thú vị tới như vậy.', N'&nbsp;Nhóm nước hoa: Hương Thơm Cay Nồng
Giới tính: Unisex
Năm ra mắt: 2014
Nồng độ: Eau De Parfum (EDP)
Độ lưu hương: Tốt 7 – 12 Giờ
Độ toả hương: Gần
Phong cách: Sang Trọng, Nhẹ Nhàng, Thu HútTầng hương đầu: Bạc hà, Tiêu đen, Quả phúc bồn tửTầng hương giữa: Trà đen, Hoa mộc lan, Hoa bất tửTầng hương cuối: Da thuộc, Nhang trầm, Gỗ phong vàng, Nhựa hương hoa hồng đá')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (9, 1, N'
	
	Kilian Angels&#8217; Share Feat French Montana
	', 100000, 100, N'Kilian-Angels-Share-Feat-French-Montana.jpg', 0, N'
									

Kilian Angel&#8217;s share feat french montana phiên bản giới hạn: Là màn kết hợp của người sáng lập Kilian Henessy và rapper người Mỹ, French Montana. Rapper và nhà pha chế nước hoa huyền thoại đã hợp tác trong Angels Share, một trong hai mùi hương đầu tiên trong bộ sưu tập The Liquors


Chai Nước hoa xuất hiện trong trong suốt, được đục các cạnh sắc xảo và được niêm phong bằng một đĩa tông màu vàng giống như đĩa hát vinyl. Các dây chuyền được chạm khắc đóng vai trò như một dấu hiệu cho thấy phong cách cá nhân của French Montana cũng như họa tiết đặc trưng của KILIAN PARIS được thấy trên nhiều sản phẩm của ông. Phát biểu về ý nghĩa của sự hợp tác mới nhất, French Montana cho biết, “Kilian đã đặt trái tim của mình vào hương thơm này. Tôi đặt trái tim mình vào âm nhạc của mình. Chúng tôi đến với bạn bằng một thứ mà chúng tôi tin tưởng”


về đêm, âm nhạc và nước hoa luôn đi đôi với nhau. Mối quan hệ giữa hai thế giới này đã cho phép nhà sản xuất mùi hương sang trọng KILIAN PARIS hợp tác với French Montana để tái hiện dòng sản phẩm chủ lực của thương hiệu, Angels ’Share.
Mang dòng dõi tám thế hệ của mình cho thương hiệu cognac huyền thoại, Angels ’Share là hương thơm thân thiết nhất của nhà sáng lập Kilian Hennessy. Anh ấy giải thích, “Tôi đã mất 14 năm để tạo ra một mùi hương lấy cảm hứng từ rượu cognac. Đó là cầu nối hoàn hảo giữa di sản Hennessy của gia đình tôi và di sản KILIAN PARIS mà tôi đang hy vọng xây dựng. ”

Kilian Angels&#8217; Share Feat French Montana một sự pha trộn dựa trên hương vị rượu cognac, với tinh chất rượu cognac chính hãng làm cho nước hoa có màu caramel có nguồn gốc tự nhiên, nó cũng có các nốt hương của cây phỉ, quế, gỗ sồi và đậu tonka. Tên của nó đề cập đến sự bay hơi một phần của rượu bên trong các thùng gỗ sồi khi ủ trong hầm rượu, bay lên giống như một sự cung cấp thầm lặng ở trên được gọi là &#8220;phần của các thiên thần&#8221;


							', N'
	Nhóm nước hoa: Hương Vani phương đông
Năm ra mắt: 2022
Giới Tính: Unisex
Nồng độ: Eau De Parfum (EDP)
Phong cách: Sang Trọng, Lôi Cuốn, Hiện Đại
Hương Đầu: Rượu Cognac
Hương giữa: Gỗ Sồi, Đậu Tonka, Quế, Hạt Phỉ
Hương cuối: Vanilla, Gỗ Đàn Hương, Amber
')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (10, 1, N'
	
	Tom Ford Orchid Soleil
	', 100000, 100, N'Tom-Ford-Orchid-Soleil.jpg', 0, N'
									

Nước hoa Tom Ford Orchid Soleil của thương hiệu Tom Ford là dòng thiết thế dành riêng cho phái nữ. Hương thơm là sự kết hợp độc đáo giữa các thành phần hoa cỏ vùng phương đông khắc nghiệt. Orchid Soleil nhẹ nhàng, sảng khoái phù hợp với tiết trời nóng nực, mùi hương sẽ giúp bạn thư thái, tự tin trước những buổi hoạt động ngoài trời như dã ngoại, mua sắm,… vì độ lưu hương lâu và độ tỏa hương xa của chai nước hoa này.

&nbsp;
Tom Ford Orchid Soleil mở ra những mùi hương mới mẽ bộc lộ được cá tính sôi động, rạng rỡ và gợi cảm được ẩn sâu bên trong của người con gái. Nhằm để khai thác những điều độc đáo đó, những nốt hương Hồng tiêu, Cây bách được lựa chọn làm sự khởi đầu đầy nồng cháy và ấm áp. Tiếp đến là những tông hương mềm mại, dịu dàng được tung ra thông qua những bông Hoa huệ đỏ và Hoa huệ trắng giúp khai thác sự gợi cảm bên trên làn da của phụ nữ. Và đặc biệt hơn cả, những nốt hương Vanilla và Kem tươi được cẩn thận sử dụng vào những khoảnh khắc cuối cùng để các nàng vẫn luôn giữ trọn được sự ngọt ngào, vui vẻ của mình cho đến hết ngày.

							', N'
	Nhóm nước hoa: Hương hoa cỏ phương Đông
Năm ra mắt: 2015
Giới Tính: Nữ
Nồng độ: Eau De Parfum (EDP)
Phong cách: Quyến Rũ, Sang Trọng, Gợi Cảm
Hương Đầu: Hồng tiêu, Cam, Cây bách
Hương giữa: Hoa huệ đỏ, Hoa huệ trắng
Hương cuối: Vanilla, Cây hoắc hương, Hạt dẻ, Kem tươi, Hoa phong lan
')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (11, 1, N'
	
	Hermes Terre D&#8217;Hermes Eau Tres Fraiche
	', 100000, 100, N'z3315677756831_1a5dfa5620a367d3beeeb4d574dfdfcf-min.jpg', 0, N'
									

Nước hoa Hermes Terre d’Hermes Eau Tres Fraiche của thương hiệu Hermes là dòng thiết thế dành riêng cho nam được ra mắt năm 2014. Thuộc nhóm hương gỗ thơm tươi mát và nhẹ nhàng thích hợp cho những hoạt động ngoài trời nắng nóng. Sản phẩm là sự lựa chọn tuyệt vời của những chàng trai năng động ưa thích thể thao.

Hermes Terre d’Hermes Eau Tres Fraiche mở đầu là hương cam, chi cam chanh mang đến cảm nhận sự phóng khoáng thư giãn tràn ngập trong không gian. Tiếp đến là mùi hương ngọt ngào của hoa phong lữ. Để rồi, lớp hương cuối cùng đọng lại trên làn da vẫn giữ nguyên các lớp hương đầu và giữa nhưng lại trở nên ấm áp và mịn màng với hương vị của hương gỗ, hoắc hương, gỗ tuyết tùng…. Tất cả hòa quyện lại với nhau một cách nghệ thuật để tạo nên Hermes Terre d’Hermes Eau Tres Fraiche – hương thơm tươi mát, nhẹ nhàng dành cho người đàn ông hiện đại.

							', N'
	Nhóm nước hoa: Hương gỗ thơm mát
Năm ra mắt: 2014
Giới Tính: Nam
Nồng độ: Eau De Toilette (EDT)
Phong cách: Tinh Tế, Lịch Lãm, Nam Tính

Hương đầu: Quả cam, Chi cam chanh, Hương nước.
Hương giữa: Hoa phong lữ.
Hương cuối: Hương gỗ, Cây hoắc hương, Gỗ tuyết tùng.

')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (12, 1, N'
	
	Roja Oceania Limited
	', 100000, 100, N'Roja-Oceania-Limited-2-5.jpg', 0, N'
									


Roja Oceania Limited được hãng nước hoa xa xỉ ???????????????? ???????????????????????????? ra mắt năm 2019 với chủ đề Đại Dương xanh, cách điệu bởi những cơn sóng biển mang theo vị Citrus tươi mát. Hương thơm của biển được sáng tạo từ các nguyên liệu tự nhiên đắt giá.



Roja Oceania Limited tự như câu nói:&#8221; Tôi như muốn chìm vào trong dòng nước mát lạnh đó. Một cảm giác sâu thẳm, bí ẩn, đẹp đẽ nhưng không thể khám phá hết được vô tận, kì diệu của chính bản thân chúng ta. Đó là một mùi hương rất đặc biệt, mang hơi thở mặn chát của biển cả, làn sáng ngọt ngào của tia nắng. Thật muốn có thể xuyên qua được hương vị đầy bí ẩn này&#8221;.




Mở đầu, Roja Oceania Limited thơm sảng khoái tươi mát của hợp hương cam chanh quyện hòa cùng oải hương và chút long diên hương khẽ khàng.
Hợp hương mặn mòi dịu nhẹ khơi gợi cảm giác đại dương lấp lánh liên tục chuyển động, rất giống món cocktail kinh điển Gin&amp;Tonic đặc trưng của thành phố London tại xứ sở Anh Quốc.


Tiếp tục trạng thái thơm mơn man và lâng lâng, hợp hương cam chanh thanh sắc dần dịu nhẹ, bách xù khiêu vũ cùng long diên hương lúc này hiện diện rõ nét hơn, kiến tạo nên hậu vị ???????????????????????????? đằm êm thăm thẳm.


Phiên bản Limited với thiết kế nắp viền 14 viên đá xanh lấp lánh, thân chai là một khối vuông sang trọng. Hương thơm say mê và thu hút . Chỉ có thể nói rằng ???????????????????????????? xứng đáng để các tín đồ nước hoa sở hữu.


							', N'
	Nhóm nước hoa: Hương gỗ thơm mát
Giới tính: Unisex
Năm ra mắt: 2019
Nồng độ: Eau De Parfum (EDP)
Độ lưu hương: Tốt 7 &#8211; 12 Giờ
Độ toả hương: Tốt
Phong cách: Sang Trọng, Tươi Mát, Trẻ Trung

Hương đầu : Quả cam Mandarin, Hoa Oải Hương, Quả chanh, Quả bưởi, Cam Bergamot, Cây hương thảo, Cỏ xạ hương và cây bời lời đỏ
Hương giữa: Hoa Violet, Hoa Phong Nữ, Hoa Nhài, Hoa Nhài Sambac và Hoa Ylang-Ylang
Hương cuối: Gỗ tuyết tùng, Hoa diên vĩ, Rêu, Xạ hương, Cỏ Vetiver, Cây Galbanum, Quả bách xù, Gỗ đàn hương, Vanilla, Labdanum và Benzoin.

')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (13, 1, N'
Hermes Terre d’Hermes Eau Intense Vetiver Gift Set', 100000, 100, N'Hermes-Terre-dHermes-Eau-Intense-Vetiver-Gift-Set.jpg', 0, N'Gift Set gồm : Nước Hoa 100ml + Tắm Gội 80mlHermes Terre D’Hermes Eau Intense Vetiver trẻ hơn, hiện đại hơn, đậm đặc hơn nhưng vẫn giữ được cốt cách sang trọng, lịch lãm và đặc biệt vốn có của hãng thời trang xa xỉ nước Pháp.Vẫn là cam tiêu gỗ gừng trứ danh nhưng được gia giảm ít nhiều, bổ sung thêm rêu sồi vetiver như 1 sự phá cách và khẳng định cá tính. Hermes Terre D’Hermes Eau Intense Vetiver với Mùi hương khô, dày, đậm, toả hương rõ nét đem đến sự mạnh mẽ rắn rỏi của 1 quý ông điển hình của nước Pháp, xa xỉ mà cũng vô cùng tinh tế&#8230;Hermes Terre D’Hermes Eau Intense Vetiver hương thơm của đất trời, hương thơm của những người đàn ông thành đạt nếu tủ nước hoa nhà các anh chưa có thì quả là một thiếu sót quá lớn Hermes Terre D’Hermes Eau Intense Vetiver mở đầu tươi mát và phóng khoáng nhờ sự giao thoa của loạt hương cơ bản cam bergamot, bưởi và chanh vàng. Tiếp đến là “trái tim” cay nồng cộng hưởng thêm một sự thăng hoa bởi những điều mà tiêu tứ xuyên và chi mỏ hạc hiển nhiên muốn chứng tỏ.
Cuối cùng, những điều phóng đãng từ cỏ hương bài lại mặc lên người nhờ những sự đan xen từ hổ phách, hoắc hương và nhũ hương khiến đối phương lại trở nên rạo rực và thèm khát được nương mình trên xác thịt.', N'Gift Set gồm : Nước Hoa 100ml + Tắm Gội 80mlNhóm nước hoa: Hương gỗ thơm mát
Giới tính: Nam
Năm ra mắt: 2018
Nồng độ: Eau De Parfum (EDP)
Độ lưu hương: Tốt 6 &#8211; 8 Giờ
Độ toả hương: Tốt
Phong cách: Nam tính, Hấp Dẫn, Phóng Khoáng
Hương đầu: cam bergamot, bưởi và chanh vàng
Hương giữa: Chi Mỏ hạc và Tiêu tứ xuyên
Hương cuối: Cỏ hương bài, Hổ phách, Hoắc hương và Nhũ hương.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (14, 1, N'
Zoologist Cow Limited Edition', 100000, 100, N'z3313083027998_048cbcb5d1d8c007c70295a20b74927e-min.jpg', 0, N'Zoologist Cow Limited Edition Là phiên bản Cô bò sữa Cow trên đồng cỏ xanh mướt mới ra mắt của nhà Zoologist. Nhìn Cưng quá chời quá đất từ thiết kế hộp, chai đến concept mùi hương luôn.Nhìn hình thì đa số mọi người đều đoán ra được mùi đúng không ạ? Zoologist Cow Limited Edition bắt đầu hành trình dạo chơi của mình, tản mát bên những ngọn cỏ non xanh mơn mởn. Bất chợt mùi của táo chín rơi xuống nơi đầu mũi, cây táo phía xa nặng trĩu những trái mọng ngọt ngào. Đâu đó lẫn trong đám cỏ, những bông violet và linh lan vừa đơm bông xao động và thả hương thơm bay lên quấn quít trong không khí trong veo. Gió bay muôn nơi, đem hương nhài từ những khu vườn tới chung vui. Ta hít thở sâu, cảm nhận thiên nhiên căng tràn trong lồng ngực; cảm giác như được ban tặng một thứ năng lượng diệu kỳ.Ở cuối cuộc vui khi ta trở về, mùi sữa bò béo ngậy chào đón ta với chiếc ôm ấm áp đầy dịu dàng. Thoang thoảng có mùi gỗ thanh sạch, một chút ngọt ấm của hổ phách và xạ hương vang lại từ nông trại nơi đàn bò đã về chuồng. Không gian tràn ngập mùi hương của sự thân thuộc khiến ta thấy an bình, cảm giác được trở về nhà thật tuyệt diệu biết bao.', N'Nhóm nước hoa: Hương hoa cỏNăm ra mắt: 2022Giới Tính: UnisexNồng độ: Extrait de ParfumPhong cách: Tinh Tế, Nhẹ Nhàng, Lôi CuốnHương đầu: Lá xô thơm, Quả táoHương giữa: Sữa, Hoa lan chuông, Cây vòi voi, Hoa violet, Hoa nhàiHương cuối: Gỗ tuyết tùng, Cỏ hương bài, Xạ hương, Hổ phách.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (15, 1, N'
Roja Enigma Essence De Parfum', 100000, 100, N'Roja-Enigma-Essence-De-Parfum-Pour-Femme.jpg', 0, N'Roja Enigma Essence De Parfum được hãng Rọa Dove ra mắt vào năm 2021 với mùi hương được sáng tạo nên từ sự quyến rũ ngọt ngào bản năng thanh xuân vĩnh hằng của người phụ nữ. Nở dịu dàng tinh tế trên da, Enigma dặt dìu đưa chủ nhân mùi hương qua từng miền trạng thái thơm một cách hài hòa, êm ái, gần gũi, dễ gây nhớ nhung.Roja Enigma Essence De Parfum mở đầu như Giọt mật hoa trắng của phấn hoa trong trẻo tinh khiết dần được nhuộm hồng bởi hoa hồng, rồi sáng lấp lánh bởi phong lữ. Lướt qua, vương lại lớp bụi là hợp thể của vani quyện hoắc hương biết gây thương nhớ. Hậu vị giàu long diên vương kèm xạ hương hòa cùng da thịt, khiến Enigma êm đềm xúc cảm và ngọt trong trẻo mơn man.', N'Nhóm nước hoa: Hương hoa cỏ Phương Đông &#8211; Amber FloraNăm ra mắt: 2021Giới Tính: NữPhong cách: Quyến Rũ, Ngọt Ngào, Sang TrọngHương đầu: Cam BergamotHương giữa: Hoa Hồng Tháng Năm, Hoa cam, Hoa nhài, Hoa phong lữ, Hoàng lan, Qủa đào.Hương cuối: Diên vĩ, Hoắc hương, Vani, Long diên hương, Xạ hương')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (16, 1, N'
	
	Guerlain Shalimar Souffle de Parfum
	', 100000, 100, N'Guerlain-Shalimar-Souffle-de-Parfum-4.jpg', 0, N'
									


Thương hiệu Guerlain đã tung ra mẫu nước hoa Shalimar Souffle de Parfum vào năm 2014, với tư cách là một phiên bản hiện đại của chai nước hoa Shalimar cổ điển đã từng được ra mắt vào năm 1925. Thierry Wasser, người đã tinh chế nên chai nước hoa mới này, đã truyền vào hương thơm cổ điển nói trên một sức sống mới với một sự gợi cảm, tinh tế và rạng rỡ. Thierry Wasser đã thành công trong việc mang lại cho hương thơm cổ điển một cái nhìn và những yếu tố mới mẻ, giúp cho dòng nước hoa Shalimar nổi tiếng này đạt lên một đẳng cấp mới của sự gợi cảm, lôi cuốn và đáng khao khát như một viên ngọc quý báu.

Guerlain Shalimar Souffle de Parfum với hương thơm của nước hoa mang một mùi hương hoa cỏ &#8211; phương Đông đầy tinh tế. Hương thơm bắt đầu trong phong vị tươi mát và nhẹ nhàng của chanh, cam bergamot và quýt hồng. Tiếp đến, hương thơm của hoa nhài Sambac Ấn Độ và chiết xuất hoa cam khiến cho lớp hương giữa trở nên rạng rỡ hơn. Điểm độc đáo của chai nước hoa này chính là sự kết hợp của hai loại hương vani, vani Haiti và vani Ấn Độ hòa quyện vào nhau tạo nên một sự ngọt ngào đậm chất phương Đông và được tăng thêm phần gợi cảm với hương thơm của xạ hương trắng&#8230;

							', N'
	Nhóm nước hoa: Hương hoa cỏ phương Đông
Năm ra mắt: 2014
Giới Tính: Nữ
Nồng độ: Eau De Parfum (EDP)
Phong cách: Quyến Rũ, Nhẹ Nhàng, Sang Trọng

Hương đầu: cam bergamot, chanh, cam mandarin
Hương giữa: hoa nhài, hoa cam
Hương cuối: xạ hương trắng, vanilla Ấn Độ, vanilla Tahihi

')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (17, 1, N'
Chloe Eau de Parfum', 100000, 100, N'Chloe-Eau-de-Parfum.jpg', 0, N'Nước hoa Chloe Eau de Parfum là cô nàng khó định nghĩa nhất về độ tuổi của nhà Chloé. Bạn có thể thấy nhiều người bàn tán về một cô gái ở tuổi mới lớn, hồn nhiên và yêu đời ở nơi cô nàng này. Nhiều cuộc hội thoại khác về Chloe Eau de Parfum nhưng ở khía cạnh trưởng thành, cuốn hút và có chút gì đó táo bạo.Chloe Eau de Parfum bật mở trong giai điệu hoa cỏ êm dịu đến từ chiết xuất hoa mẫu đơn, vải và lan Nam Phi của mùa xuân. Từ từ, Chloe đưa người sử dụng đắm chìm trong hương vị phóng khoáng ve vãn của tầng hương giữa với tinh chất hoa hồng phong phú và gợi cảm tuyệt vời. Phong vị mộc lan và hoa lan chuông đan xen, cùng hổ phách ấm áp và tuyết tùng thanh lịch bất ngờ gieo vào khu vườn hương thơm những thanh âm tươi mới. Chloe tinh nghịch quấn quýt trong xúc cảm nữ tính. Sau đó mượn thêm chút cổ điển của hoa hồng xinh đẹp và nhuộm trong gam màu hiện đại đó hô biến thành một mùi hương sôi động và tràn đầy năng lượng. Từ mờ ảo hóa ấm áp, lôi cuốn và hoàn toàn gây nghiện.Chloe Eau de Parfum là mùi hương nổi tiếng nhất và được yêu thích nhất của Chloe trong gần 1 thập kỉ qua. Mùi hương của một người phụ nữ trưởng thành, quyền lực và sang trọng. Một mùi hương đậm vị hoa hồng, thứ hoa hồng Damascena đắt đỏ và quyền uy của châu Âu, quyện với chút hổ phách ngọt ngào và ấm áp. Mùi hương không hổ danh là biểu tượng của nước hoa Chloe.', N'Nhóm nước hoa: Hương hoa cỏ phương đôngNăm ra mắt: 2008Giới Tính: NữNồng độ: Eau De ParfumPhong cách: Cuốn Hút, Quyến Rũ, Năng ĐộngHương Đầu: Hoa mẫu đơn, Hoa lan Nam Phi, Quả vảiHương giữa: Hoa hồng, Hoa linh lan thung lũngHương cuối: Hổ phách, Gỗ tuyết tùng')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (18, 1, N'
Marc Jacobs Perfect Intense', 100000, 100, N'Marc-Jacobs-Perfect-Intense-5.jpg', 0, N'Lấy cảm hứng từ châm ngôn sống được Marc Jacobs vô cùng tâm đắc: “Tôi hoàn hảo theo cách của riêng mình” – đây là dòng nước hoa được tạo ra để tôn vinh những bản thể độc đáo trong mỗi chúng ta. Nhà thiết kế này cho biết: “Thế giới là hoàn hảo, và mọi trải nghiệm tôi đã có đều hoàn hảo, nếu tôi chọn thu thập một số học hỏi từ nó. Từ “hoàn hảo” đối với tôi không chỉ đại diện cho một cá nhân mà là nhiều người”.Marc Jacobs Perfect vốn dĩ đã rất hoàn hảo như cái tên của nó, nhưng Marc Jacobs Perfect Intense lại là một phạm trù khác, một lựa chọn cho những ai luôn hướng mình đến chủ nghĩa hoàn hảo, sự chỉn chu và có thể nói, góc cạnh hơn nhiều.Marc Jacobs Perfect Intense thực sự đột phá khi ra mắt hương thơm của mình. Những đóa hoa thủy tiên trắng mở ra hương thơm thơm ngát, xanh mùi hương tự nhiên. Dẫn dường cho sự quyến rũ của hoa dạ lý hương ngọt ngào, ngây ngất lan tỏa. Hương bay đi thế chỗ ngay vào đó là vị ngọt bùi, thơm nức của hạnh nhân rang vàng. Hương thơm nồng ấm lại không quá đậm mùi, ngọt sắc như thường thấy ở Vanilla. Cuối cùng để lại trên làn da nàng là dư vị của ấm áp của gỗ đàn hương. Gỗ đàn hương ấm áp, thơm mùi gỗ xanh bền bỉ lưu giữ trên cơ thể nàng.', N'Nhóm nước hoa: Hương Hoa Cỏ Phương Đông &#8211; Amber FloraNăm ra mắt: 2021Giới Tính: NữNồng độ: Eau De ParfumPhong cách: Nổi Bật, Gợi Cảm, Tinh TếHương đầu: Hoa thuỷ tiên, Hoa nhài
Hương giữa: Hạnh nhân
Hương cuối: Gỗ đàn hương')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (19, 1, N'
Narciso Rodriguez For Her EDT', 100000, 100, N'Narciso-Rodriguez-For-Her-Eau-de-Toilette-5.jpg', 0, N'Narciso Rodriguez For Her Eau de Toilette là dòng nước hoa for Her đầu tiên của hãng Narciso Rodriguez, phát hành vào năm 2004, đánh dấu sự ra đời của bộ sưu tập nước hoa for Her kinh điển cho tới tận bây giờ.Narciso Rodriguez For Her EDT với thiết kế chai với màu đen đầy bí ẩn, tạo sự tò mò và khơi gợi lên mùi hương gợi cảm bên trong. Hương đầu mở ra một thế giới ngọt ngào mát lành với hoa mộc tê, hoa cam Châu Phi, cam Bergamot. Đưa người ta từ bất ngờ này sang bất ngờ khác, hương giữa tựa một lời mời gọi ý nhị đầy gợi tình bởi xạ hương, hổ phách. Tông cuối dịu dàng mang về sự bình yên, nhẹ nhàng vốn dĩ nhờ sự kết hợp hài hòa giữa cỏ hương bài, lan nhiệt đới và cây hoắc hương.Hương thơm thích hợp dành cho những cô nàng sống nội tâm, tuy nhiên dù hướng nội nhưng cô ấy rất yêu thiên nhiên, luôn hướng về thế giới bên ngoài và trân trọng từng khoảnh khắc nhỏ bé trong cuộc sống.', N'Nhóm nước hoa: Hương hoa cỏ Gỗ Xạ hương &#8211; Floral Woody MuskNăm ra mắt: 2004Giới Tính: NữNồng độ: Eau De ToilettePhong cách: Trẻ Trung, Nữ Tính, Gợi Cảm, Dịu DàngHương đầu: Hoa mộc tê, hoa cam, cam bergamot.
Hương giữa: Xạ hương, hổ phách.
Hương cuối: Cỏ hương thảo, lan nhiệt đới, hoắc hương.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (20, 1, N'
Guerlain Cherry Blossom Limited 2022', 100000, 100, N'Guerlain-Cherry-Blossom-Limited-2022.jpg', 0, N'Guerlain Cherry Blossom là phiên bản giới hạn hàng năm của hãng Guerlain để kỷ niệm mùa xuân ở Nhật BảnTrong tất cả các nghi lễ của đất nước Mặt trời mọc, đây là nghi lễ nên thơ nhất. Mỗi độ xuân về, người Nhật lại tụ tập để chiêm ngưỡng vẻ đẹp của hoa anh đào. Guerlain kỷ niệm truyền thống hàng năm này bằng một phiên bản giới hạn mỗi năm chỉ có hơn hai nghìn chai trên cả thể giới. Đối với phiên bản năm 2022, Guerlain đã yêu cầu xưởng thêu Kyoko Création do nghệ sĩ Kyoko Sugiura thành lập để tạo ra những bông hoa trang trí tinh tế cho mặt bích của nó, được chế tác bởi một cộng đồng thợ thêu cao cấp Nhật Bản. Một sự hợp tác nghệ thuật độc đáo và thơ mộng giữa Pháp và Nhật Bản. ”- Guerlain Cherry Blossom”Mỗi năm vào tháng Giêng, người Nhật bắt đầu theo dõi hoa sakuras nở dần từ quần đảo Okinawa ở phía nam đất nước đến đảo Hokkaido ở phía bắc, vào cuối tháng 4. Được gọi là &#8220;hanami&#8221;, có nghĩa là &#8220;ngắm hoa&#8221;, nghi lễ được thực hiện bởi mọi người ở mọi lứa tuổi và hoàn cảnh. Gia đình và bạn bè tụ tập để ngạc nhiên trước vẻ đẹp của những cây anh đào phủ đầy tuyết, nhuốm màu hồng phấn… Ngắm nhìn sakuras dưới ánh trăng là một khoảnh khắc đặc biệt xúc động trong lễ kỷ niệm mùa xuân. Trắng như mặt trăng soi bóng họ trên nền đen nhánh, phù du nhưng vĩnh cửu như chu kỳ của các mùa, hoa anh đào khơi dậy một thứ tình cảm gắn bó sâu sắc trong văn hóa Nhật Bản: đơn độc không nhận thức, Một sự nhạy cảm được chia sẻ bởi những người làm nước hoa, người mà nghệ thuật của họ cũng nắm bắt được vẻ đẹp thoáng qua của hoa.Mùi hương của  Guerlain Cherry Blossom Limited 2022 Làm thế nào để cảm xúc sinh ra từ thưởng thức cảnh hoa anh đào nở có thể được thể hiện trong một cái chai? Làm thế nào có thể tạo ra một hương thơm của mùa xuân vĩnh cửu cho những bông hoa mỏng manh nhưng lại tràn đầy sức sống và cực kỳ lôi cuốn? Đây là thử thách nghệ thuật mà Jean-Paul Guerlain đặt ra khi ông sáng tác Cherry Blossom. Mở đầu với Ánh Trăng vàng của mùa xuân, Ánh sáng rực rỡ của nó được phản chiếu bởi cam bergamot rạng rỡ, đặc trưng khứu giác của Nhà Guerlain hòa quyện với hương vị trà xanh gợi lên cảm xúc nơi đồng cỏ mênh mông, thanh thản, nhẹ nhàng và tĩnh lặng. Tiếp nối sau đó là các nốt hương vô cùng tinh khiết như những cánh hoa anh đào dưới ánh trăng (Dịu dàng, thanh tao, thu hút), một màu hồng phấn, mỏng manh như cánh hoa anh đào, mềm mại như một bài thơ haiku của Nhật Bản đang suy ngẫm về sự phát triển của cuộc đời, kèm với đó là Tử Đinh Hương và Hoa Nhài làm bừng lên sức sống trong bầu trời đêm. Với điểm nhấn là  các vệt xạ hương trắng mỏng manh mang theo hương thơm tinh tế, như làn gió mang theo hoa anh đào, chiếu sáng trong đêm với muôn vàn cánh hoa trăng Nhẹ Nhàng và Thu Hút.', N'Gift Set Gồm Hũ 125ml và ống Mini 20mlNhóm nước hoa: Hương Hoa CỏNăm ra mắt: 2022Giới Tính: NữNồng độ: Eau De ToilettePhong cách: Sang Trọng, Thu Hút, Dịu DàngHương đầu: Cam Bergamot, Trà Xanh
Hương giữa: Hoa Anh Đào, Tử Đinh Hương, Hoa Nhài
Hương cuối: Xạ Hương Trắng')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (21, 2, N'
Kilian A Kiss from a Rose', 100000, 100, N'Kilian-A-Kiss-from-a-Rose.jpg', 0, N'Với mùi hương chủ đạo là hoa hồng. Hoa hồng không đơn giản chỉ là sự ngọt ngào  mà hoa hồng còn có gai. Kilian A Kiss from a Rose còn mang lại sự cá tính, huyền bí ,bên cạnh đó là một sự sang trọng, trang nhã của người phụ nữ. Bạn định nghĩa thế nào về một nụ hôn? Một lần chạm giữa 2 đôi môi và đó là biểu tượng của tình yêu? Một sự đồng điệu trong khoảnh khắc khiến cả hai biết được thế nào là nụ hôn của tình yêu.Nhưng với Kilian A Kiss from a Rose khoảnh khắc tuyệt đẹp của nụ hôn được miêu tả như sự tỏa hương từ Hoa Hồng, một loài hoa biểu trưng cho tình yêu và sự quyến rũ. A Kiss From A Rose là một khoảnh khắc được lưu giữ như một ký ức tuyệt đẹp khi mùi hương của Hoa Hồng Tháng Năm được chọn để làm tông hương chủ đạo hòa quyện cùng Quả Lý Chua Đen và Hoa Nhài Sambac mang đến những cảm xúc vỡ òa và thăng hoa khi con người ta đang khao khát để hòa mình vào dòng chảy tình yêu.Sự ấm áp và nồng nàn từ những môi hôn trao nhau, Xạ Hương Trắng xuất hiện như một đốm lửa loe lói nhưng vô cùng mãnh liệt minh chứng cho tình yêu sâu thẳm cùng những cảm xúc khiến cả hai trở nên hòa hợp mãi mãi.', N'Nhóm nước hoa: Hương Hoa Cỏ Phương ĐôngGiới tính: NữNăm ra mắt: 2021Nồng độ: Eau De Parfum (EDP)Phong cách: Sang Trọng, Tinh Tế, Gợi CảmHương đầu: Note hương xanh, Quả lý chua đen
Hương giữa: Hoa hồng tháng Năm, Hoa nhài Sambac
Hương cuối: Cây cói, Xạ hương trắng')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (22, 2, N'
Marc Jacobs Daisy Eau So Intense', 100000, 100, N'Marc-Jacobs-Daisy-Eau-So-Intense-4.jpg', 0, N'Với sự hợp tác của nhà pha chế nước hoa bậc thầy Albert Morilla, Marc Jacobs vừa tung ra một sáng tạo mới đầy thách thức thuộc bộ sưu tập Daisy với vẻ đẹp tươi vui và rực rỡ. Marc Jacobs Daisy Eau So Intense được rót vào những giọt mật ong sánh mịn để tạo nên vị ngọt đậm đà và say đắm hơn so với những dòng nước hoa Daisy trước đó. Hương thơm được mô tả là phong phú, sôi động như thể đang chứa đựng thứ ánh sáng lấp lánh làm không gian trở nên bừng sáng.Marc Jacobs Daisy Eau So Intense là phiên bản mới nhất của Daisy 2007, giống như là cô gái đã lớn, nay đã trưởng thành từ những ngày còn là thanh thiếu niên năm 2007. Sản phẩm mang hương thơm cuốn hút, ngọt ngào của nhóm hương hoa cỏ phương đông. Cho nàng thêm tươi trẻ, tự tin và thu hút khi đứng giữa đám đông. Sản phẩm giống như một phiên bản hoàn chỉnh về cả hương thơm lẫn phong cách. Đến với năm 2021, Daisy không còn là một cô gái vô tư, dễ thương nữa mà trở nên thưởng thành, tự tin hơn.Marc Jacobs Daisy Eau So Intense là chân dung một người phụ nữ khác hẳn, không còn đơn thuần là vẻ đẹp trong sáng, mỏng manh mà từng đường nét đã trở nên sắc sảo và cám dỗ mãnh liệt hơn. Trong phần mở đầu Marc Jacobs Daisy Eau So Intense vẫn giữ nguyên thành phần đặc trưng của các phiên bản Daisy với hương thơm từ quả dâu tây ngon ngọt, được kết hợp với cam Bergamot và lê giòn tươi, mọng nước. Vị ngọt nhẹ của trái cây dần được nhấn mạnh hơn nhờ vào sự góp mặt của mật ong, kết hợp với hương hoa nhài và nụ hoa hồng. Trong hoa vốn đã có mùi hương từ mật, lại được phủ một lớp mật lên phần cánh mỏng manh, yếu tố ngọt ngào được nhấn mạnh khiến sự hấp dẫn trở nên quyết liệt hơn. Khi đã đủ thuyết phục, Marc Jacobs Daisy Eau So Intense dần trở nên ấm áp và dịu dàng với sự pha trộn của benzoin, vani và xạ hương, với sự bổ sung của rêu.', N'Nhóm nước hoa: Hương Hoa Cỏ Phương ĐôngNăm ra mắt: 2021Giới Tính: NữNồng độ: Eau De Parfum (EDP)Phong cách: Ngọt Ngào, Quyến Rũ, Cuốn HútHương đầu: Dâu Tây, Lê, Cam Bergamot
Hương giữa: Mật Ong, Hoa Nhài, Hoa Hồng
Hương cuối: Benzoin, Rêu, Vani, Xạ Hương')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (23, 2, N'
	
	Maison Francis Kurkdjian &#8211; MFK L&#8217;Homme A La Rose
	', 100000, 100, N'Maison-Francis-Kurkdjian-LHomme-A-La-Rose-1.jpg', 0, N'
									

Vẫn là câu chuyện nói đi rồi vẫn nói lại, note Rose – Hoa Hồng luôn là note hương hay được gắn liền với các mùi hương dành cho phái nữ. Và nó cũng là một note hương được sử dụng thậm chí là “lạm dụng” nhất của ngành nước hoa. Vì quanh đi quẩn lại với các mùi hương Floral kiểu gì bạn cũng phải gặp ít nhất 5/10 mùi có chứa note Hồng. Các anh lại càng không bao giờ có “quyền” được mặc Hồng, vì Hồng đa phần chúng ta hay gặp sẽ là những mùi hương hoặc là trẻ trung thiếu nữ, hoặc là gợi cảm lả lơi, hoặc lãng mạn xuân thì…

Và một lần Francis Kurkdjian đã bình quyền cho cánh đàn ông với Lumiere Noire đầy chất classy lãng đãng cổ điển, lần này với bộ sưu tập À La Rose, bộ mùi chủ điểm Hồng, thì phiên bản L’Homme được ra mắt như một lần nữa để chứng minh, Hồng chỉ là một loài hoa đẹp, và nó hoàn toàn có thể đẹp trên da cả 2 giới!

Khác với kiểu mùi trẻ trung thiếu nữ, miêu tả thời khắc thanh xuân đẹp nhất của Marie Antonette trong À La Rose, phiên bản L’Homme được hiện diện như một điểm sáng khác trong thế giới vốn đã “tràn lan” mùi Hồng. Xịt ra ngửi không đơn giản là bạn thấy Hồng ngay, nó là một sự cân bằng, blend mượt và đẹp vẫn đúng theo chất của MFK làm mùi lâu nay, thứ hương ngửi lướt qua chỉ biết nó là tông hoa Floral, lại có chút fruity ngọt ngào. Hình ảnh hoa Hồng đang tan chảy trong làn nước mát mẻ của mùi trái Bưởi mọng nước, quấn quýt cùng hoa hồng Damask bừng sáng. Thế nhưng, càng để lâu trên da, mùi hương càng trầm ấm trở lại, với hoa hồng Centifolia rõ nét hơn được hòa quyện cùng gỗ hổ phách ấm nồng từ từ len lỏi vào da thịt. Đến đây, tôi mới thấy Maison Francis Kurkdjian thật khéo léo, mùi hương như một note trầm thể hiện sức mạnh ngầm của đàn ông, còn hoa hồng mơ màng ấy, là sự dịu dàng, mà cũng là bình tĩnh mà chỉ người đã từng trải mới có được. Mùi hương Hồng dù tưởng chừng như điệu, nhưng vẫn có những nét riêng để đánh giá rằng nó mang đầy đủ chất nam tính và hiện đại cần thiết mà MFK luôn làm rất tốt như một bản năng.

							', N'
	Nhóm nước hoa: Flora Wood Musk
Giới tính: Nam
Năm ra mắt: 2020
Nồng độ: Eau De Parfum (EDP)
Phong cách: Sang Trọng, Lãng Mạn, Tinh Tế
Hương Chính: Hoa hồng tháng Năm, Hoa hồng Damask, Quả bưởi, Gỗ hổ phách, Hoa labdanum Tây Ban Nha, Cây xô thơm
')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (24, 2, N'
Tom Ford Rose De Chine', 100000, 100, N'Tom-Ford-Rose-De-Chine-5.jpg', 0, N'Tom Ford Rose De Chine &#8211; Bông hồng của người phụ nữ hiện đại &lt; ???????????? ???????????????????????????????? 2022 &gt;Có thể nhiều người sẽ nghĩ rằng “ hoa hồng “ chỉ đến vậy , giản đơn nhưng tôi dám chắc các bạn sẽ thấy bông hồng của ???????????????????? hoàn toàn khác biệt Không còn những nguyên liệu “ Trời Âu xa xôi “ , Tom Ford Rose De Chine gần gũi , mềm mại mang vẻ đẹp Châu Á rất nịnh mũi luôn ạ Tom Ford Rose De Chine lan toả khắp không gian , đánh thức mọi giác quan bằng hương hoa mẫu đơn Trung Quốc mảnh mai yêu kiều và được kết hợp Hoa Hồng đằm thắm , lay động xúc cảm của đối phương khiến họ ngẩn ngơ cứ chìm đắm trong sự mê hoặc đầy cám dỗ nhưng không hề sỗ sàng mời mọc bởi Tom Ford Rose De Chine rất Thanh Lịch &amp; Gợi cảm đủ khiến người ta phải nói với nhau về “ cô gái “ ấy rằng : “ Em ấy sang lắm , trẻ trung lắm và cũng rất kiêu sa nữa “Tom Ford Rose De Chine là sự kết hợp tài tình của Hoa Hồng &amp; Hoa Mẫu Đơn và những mùi hương như sinh ra là để cho nhau: Xạ Hương, Mộc Dược, Gôm Nhựa Thơm Labdanum&#8230; hợp hương long lanh như ánh sáng hổ phách ấm áp. Độ lưu hương ấn tượng và tỏa hương khá xa khiến không chỉ người dùng mà những người xung quanh cũng được tận hưởng và &#8220;chiêm ngưỡng&#8221; mùi hương tuyệt sắc này.Nếu bạn vẫn đang loay hoay chọn cho mình một mùi hương mang hương thơm “ Sang Trọng không được tầm thường , đặc biệt phải khác biệt “ thì Tom Ford Rose De Chine sẽ là lựa chọn hàng đầu đến với bạn', N'Nhóm nước hoa: Amber FloraGiới tính: UnisexNăm ra mắt: 2022Nồng độ: Eau De Parfum (EDP)Phong cách: Ngọt Ngào, Sang Trọng, Hiện ĐạiHương đầu: Hoa Mẫu ĐơnHương giữa: Hoa HồngHương cuối: Hổ Phách, Xạ Hương, Mộc Dược, Nhựa Thơm')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (25, 2, N'
Armaf Club de Nuit Man Limited Edition Parfum', 100000, 100, N'Armaf-Club-de-Nuit-Man-Limited-Edition-Parfum-2.jpg', 0, N'Sau sự thành công của Club De Nuit Intense  ra mắt năm 2015, Thương hiệu Armaf đã cho ra mắt phiên bản đặc biệt giới hạn của sản phẩm này Club De Nuit Man Limited Edition Parfum với hương thơm đậm đà nhất so với các nồng độ EDP và EDT trước đâyArmaf Club de Nuit Man Limited Edition Parfum là 1 bản dupe hoàn hảo nhất của nhà Armaf với dòng Creed Aventus, được giới nước hoa đánh giá là tinh hoa hội tụ của tất cả các bản clone Aventus từ trước tới nay, là đỉnh cao của mùi hương&#8230;Armaf Club de Nuit Man Limited Edition Parfum là 1 bản dupe hoàn hảo nhất của nhà Armaf với dòng Creed Aventus, được giới nước hoa đánh giá là tinh hoa hội tụ của tất cả các bản clone Aventus từ trước tới nay, là đỉnh cao của mùi hương&#8230;Với phiên bản đặc biệt Luxury Limited Edition Parfum này, cảm giác chua gắt của nốt hương đầu vừa xịt không còn nữa mà thay vào đó là nhiều hương dứa và khói hơn hòa quyện luân phiên tạo nên sự uyển chuyển hơn. Hương gỗ cũng được đẩy lên cao hơn các bản EDT, EDP và Limited 2020 cũ, lưu hương cả ngày dài cũng là điều nổi bật của chai này&#8230;', N'Nhóm nước hoa: Woody Spicy ( Hương Gỗ Thơm Cay Nồng )Giới tính: NamNăm ra mắt: 2021Nồng độ: ParfumPhong cách: Nam Tính, Hiện Đại, Cuốn HútHương đầu: Dứa, nho đen, táo, cam bergamot.Hương giữa: Hoa hồng, hoa nhài, bạch dương.Hương cuối: Vanilla, long diên hương, hoắc hương, xạ hương.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (26, 2, N'
Gift Set YSL Yves Saint Laurent Libre', 100000, 100, N'Set-Yves-Saint-Laurent-Libre.jpg', 0, N'Set Gồm :– Nước hoa Yves Saint Laurent Libre EDP 90ML– Nước hoa Yves Saint Laurent Libre EDP 7.5ML– Son Yves Saint Laurent Kem Màu 208Yves Saint Laurent Libre là hương thom đại diện của tự do trong thời đại mới. Một loại nước hoa tuyên ngôn cho chính bản thân người dùng. Được ra mắt vào năm 2019 bởi sự bắt hay hợp tác giữa chai chuyên gia nước hoa Anne Flipo và Carlos Benaim.  Thiết kế của Libre gây ấn tượng mạnh mẽ về tính độc đáo, sang trọng và tinh tế mà hãng Yves Saint Laurent vẫn thường ưu ái dành cho các bộ sưu tập thời trang danh tiếng của mình.Yves Saint Laurent Libre là một mùi hương hoa Phương Đông, nổi bật với nhóm hương chính như Hoa lavender quyến rũ và Hoa cam tươi mát, thảo mộc. Sự góp mặt của Vani giúp cô nàng Libre trở nên ngọt ngào và quyến rũ hơn, nhưng vẫn giữ được độ thanh lịch và tươi mới khi Note hương cam vẫn hiện hữu. Sự sang trọng, gợi cảm và cá tính là điều hãng Yves Saint Laurent muốn gửi gắm đến cô nàng bí ẩn này.Son YSL kem 208 Rouge Faction mang một sắc đỏ tươi cực cuốn hút, không gây khô môi, bám màu cực tốt giữ được cả ngày. ban đầu đánh lên khá là căng mọng một lúc sau sẽ lì mướt siêu xinh luôn nhé.', N'Set Gồm :– Nước hoa Yves Saint Laurent Libre EDP 90ML– Nước hoa Yves Saint Laurent Libre EDP 7.5ML– Son Yves Saint Laurent Kem Màu 208Nhóm nước hoa: Hương va-ni phương đôngGiới tính: NữNăm ra mắt: 2021Nồng độ: EDPĐộ lưu hương: Lâu – 7 giờ đến 12 giờĐộ toả hương: XaPhong Cách: Sang Trọng, Nữ Tính, Lôi CuốnHương Đầu: Cam bergamot, Hoa oải hương, Lý chua đen, Hoa lanHương giữa: Hoa nhài, Hoa cam, Hoa oải hươngHương cuối: Hương Va ni, Gỗ tuyết tùng, Long diên hương, Xạ hương')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (27, 2, N'
Kilian Good Girl Gone Bad Paradise Garden Limited', 100000, 100, N'Kilian-Good-Girl-Gone-Bad-Paradise-Garden-Limited.jpg', 0, N'Good Girl Gone Bad là một sản phẩm nước hoa đến từ nhãn hiệu By Kilian dành cho phái nữ, được cho ra mắt thị trường vào năm 2012. Sản phẩm được xếp duyệt vào nhóm nước hoa hương hoa cỏ trái cây. Mùi hương mở ra cho ta thấy một cô gái trẻ trung, xinh xắn trong bộ váy trắng tinh khiết, nhưng càng đi sâu thì cô gái đó càng bộc lộ sự nổi loạn bên trong bản thân mìnhKilian đã đạt đến đỉnh cao của sự tinh tế khi cho ra sản phẩm Kilian Good Girl Gone Bad Paradise Garden Limited với chiếc Cluth được gắn bộ tranh Tùng &#8211; Cúc &#8211; Trúc &#8211; Mai hay còn gọi là Tứ Quý. Tranh Tứ quý được nói đến như sự may mắn, sức khỏe, tài lộc cho gia chủ trong cả một năm. Tứ quý là bốn mùa, bốn mùa trong năm, 12 tháng đều bình an, vạn sự như ý&#8230;Với Kilian Good Girl Gone Bad Paradise Garden Limited Bạn có thể yêu mùi hương này ngay từ khi bạn đọc các ghi chú về thành phần mùi hương, một quả bom làm bằng Hoa, và đặc biệt là hoa trắng đang sẵn sàng chờ đợi được châm ngòi từ cú xịt đầu tiên của bạn. Một vẻ đẹp tinh khôi nhưng chẳng kém phần mạnh mẽ. Tôi sẽ lý giải cho bạn vì sao tôi gọi đây là một quả Bom, đơn giản vì nó có sức mạnh lan tỏa và lấn át những mùi hương xung quanh một cách khó tin. Lưu ý với mọi người rằng Good Girl Gone Bad By Kilian không phải là một chai nước hoa đậm mùi hay là ngọt, sức mạnh của nó đến từ việc cộng hưởng các note hương hoa một cách tinh tế và táo bạo, và điều đó đã biến cô nàng này trở nên cuốn hút một cách khó tin. Hoa mộc tê, Hoa Huệ, Hoa nhài, Hoa thủy tiên, Hoa hồng tháng 5, cả một vườn hoa chen nhau tỏa hương, biến cô nàng này trở bên nổi bật một cách nữ tính và đầy gợi cảm. Bạn sẽ nhận được một tín hiệu cảm xúc lẫn lộn đầy khó hiểu khi tiếp xúc với cô nàng này, giống như cái tên của cô ấy vậy, Good và Bad, quá khó để định nghĩa được cô nàng này khi cảm hứng của đối phương chỉ dành cho những lời đường mật, với mục đích tiếp cận thật nhanh thay vì phán xét tốt xấu ở nơi cô ấy xuất hiện. Phụ nữ mạnh mẽ, đẹp và gợi cảm, thì có lẽ tốt hay xấu chỉ là tính từ phụ để mang lên bàn cân mà thôi phải không các chàng trai', N'Nhóm nước hoa: Hương hoa cỏ trái câyGiới tính: NữNăm ra mắt: 2022Nồng độ: EDPĐộ lưu hương: Lâu – 7 giờ đến 12 giờĐộ toả hương: Gần – Toả hương trong vòng một cánh tay.Phong Cách: Sang Trọng, Tinh Tế, Quyến RũHương đầu: Hoa nhài, Hoa mộc tê, Hoa hồng tháng nămHương giữa: Hoa huệ trắng Ấn Độ, Hoa thủy tiênHương cuối: Hổ phách, Gỗ tuyết tùng')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (28, 2, N'
	
	Lancome La Vie Est Belle Soleil Cristal
	', 100000, 100, N'lancome-la-vie-est-belle-soleil-cristal-9.jpg', 0, N'
									

Lancome La Vie Est Belle Soleil Cristal được cho ra mắt vào năm 2021 mang sắc màu rực rỡ như hiệu ứng tản xạ ánh sắc đầy lộng lẫy của mùa hè nhiệt đới, tinh thần tươi trẻ của những quý cô thời thượng được lan toả qua sự sáng tạo mùi hương đầy năng lượng từ tinh chất vanila, hoa nhài, hoa diên vỹ, hoắc hương, ngọc lan tây.

Hạnh phúc không chỉ là cảm giác, nó là ánh hào quang tỏa ra xung quanh như ánh mặt trời trong ngày hè ấm áp. Lancome La Vie Est Belle Soleil Cristal (Crystal Sun) nắm bắt được bản chất của một ngày hè đầy nắng và tạo ra hương nước hoa Lancôme đầy ngọt ngào và tươi mát. Đây đích thị là hương nước hoa làm được điều không tưởng. Bởi mặc dù mang tông mùi chủ đạo là mùi ngọt nhưng bạn có thể vô tư sử dụng vào mùa hè đầy nắng&#8230;

Những cảm nhận đầu tiên khi sử dụng là hương thơm vô cùng lôi cuốn bởi mùi tiêu hồng, và mát mẻ của Cam Bergamot. Sau đó hoàn toàn là hương dừa và vani kết hợp với hương từ các loại hoa nở rộ. lancome la vie est belle soleil cristal sau khoảng 3 tiếng có hương thơm dịu dần, và được làm tươi mới bởi trái cây, thơm. Mang lại cảm giác thư thái và dễ chịu. Do vậy mà rất nhiều người chia sẻ rằng càng về sau họ càng yêu cái mùi hương này hơn

&nbsp;
							', N'
	Nhóm nước hoa: Hương Hoa Cỏ
Giới tính: Nữ
Năm ra mắt: 2021
Nồng độ: Eau De Parfum (EDP)
Phong cách: Quyến Rũ, Ngọt Ngào, Sang Trọng

Hương đầu: Quýt hồng, hồng tiêu, cam bergamot
Hương giữa: Hoa ngọc lan tây, hoa cam, hoa nhài, hoa diên vỹ
Hương cuối: Hương vanilla, hoắc hương, quả dừa

')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (29, 2, N'
Dior Sauvage Elixir', 100000, 100, N'Dior-sauvage-elixir.jpg', 0, N'Dior Sauvage Elixir vẫn mang được vẻ phong độ của người đại diện Johnny Depp cùng thiết kế chai đầy táo bạo khi hình ảnh thon gọn, bo tròn đã không còn nữa, thay vào đó là một hình dáng nhỏ gọn, chỉ vỏn vẹn 60ml cho phiên bản full thuận tiện cho việc mang đi bên mình một cách dễ dàng.Một điều không thể phủ nhận, phiên bản Dior Sauvage tiền nhiệm (EDT, EDP, Parfum) vẫn luôn là chủ đề nóng bỏng và được săn đón nhất từ lúc ra cho đến đến thời điểm hiện tại cùng mùi hương nam tính, nóng bỏng của tông chủ đạo Fresh-Spicy. Mang trong mình mùi hương warm-spicy, hương thơm cay ấm, mùi hương từ Dior Sauvage Elixir là một sự thay đổi cục diện khi được đánh giá có nhiều điểm nổi trội hơn từ cách thiết kế giữa các tầng hương.Dior Sauvage Elixir mở đầu là một hỗn hợp nhiều sắc thái khác nhau, sự cay ấm từ Quế và Bạch Đậu Khấu như đặc quyện cùng mùi hương Nhục Đậu Khấu rồi lại được cân bằng nhờ hương Bưởi khiến mùi hương dễ dàng tiếp cận, không bị quá mạnh mẽ. Tiếp nối là sự xuất hiện độc nhất của Hoa Oải Hương ở ngay lớp hương giữa, sự xuất hiện đầy táo bạo này đã cộng hưởng với Quế làm nên một trùm hương ấm ngọt đang bùng nổ rực rỡ giữa khung trời đêm đầy hoang dã, mà nơi đó, ánh trăng đang dần chuyển đỏ như một sự khẳng định táo bạo đầy mạnh mẽ của một không gian ma mị.', N'Nhóm nước hoa: Hương gỗ cay nồngGiới tính: NamNăm ra mắt: 2021Nồng độ: ParfumPhong cách: Mạnh Mẽ, Hấp Dẫn, Quyền LựcHương Đầu: Quế, Bạch Đậu Khấu, Nhục Đậu Khấu và Quả Bưởi;
Hương Giữa: Hoa Oải Hương;
Hương Cuối: Gỗ Đàn Hương, Cam Thảo, Hổ Phách, Cỏ Vetiver Haiti và Cây Hoắc Hương.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (30, 2, N'
Amouage Overture For Men', 100000, 100, N'Amouage-Overture.jpg', 0, N'Amouage Overture For Men Phiên bản ᴇxᴄʟᴜsɪᴠᴇ đắt đỏ sản xuất cực giới hạn và chỉ được Amouage sản xuất riêng cho thị trường London và bày bán ở thiên đường hàng xa xỉ ????????????????????????????, không khó để giải thích vì sao Amouage Overture For Men vẫn luôn cháy hàng kể từ khi mới ra mắt đến tận bây giờ. Và cũng không ngoa khi nhận xét đây là chai nước hoa hay nhất, đắt nhất và khó kiếm nhất trong các line của Amouage.Với mùi Cognac đậm nồng kết hợp cùng nhựa thơm trên nền gỗ đàn hương ám khói ẩn mình trong chất juice trong suốt óng ánh màu vàng kim, Amouage Overture For Men mang đến cảm giác cực kì vương giả và quyền lực – thứ chỉ có ở những người dẫn đầu. Nó mạnh mẽ và áp đảo đến mức chỉ ???? shot thôi cũng đủ để bao trùm lên tất cả những mùi hương bạn từng thử qua trước đóMùi hương của những gã trai lịch thiệp ưa say sưa khề khà. Rượu cognac ấm áp, mạnh bạo, bốc khói ngút ngàn.', N'Nhóm hương:Hương Gỗ Rượi thơm nồngGiới tính:NamNồng độ:Eau de ParfumPhát hành:2019Phong cách: Lôi Cuốn, Mạnh Mẽ, Sang TrọngHương đặc trưngHương đầu : Rượu Cognac, Thì là, Nhục đậu khấu, Bạch đậu khấu, Nghệ tây, Quả bưởi và GừngHương giữa : Myrrh, Benzoin, Labdanum, Cinnamon, Mastic or Lentisque, Patchouli và GeraniumHương cuối : Gỗ đàn hương, Khói, Hương động vật, Da thuộc, Hương trầm và Cây xô thơm.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (31, 2, N'
Gucci Guilty Eau Pour Homme', 100000, 100, N'Gucci-Guilty-Eau-Pour-Homme-3.jpg', 0, N'Gucci Guilty Eau Pour Homme với thiết kế đầy mạnh mẽ và nam tính, Gucci Guilty Pour Homme đã phần nào toát lên nét đẹp vững chãi, lãng du của mình chỉ qua một cái nhìn.Gucci Guilty Eau Pour Homme mở đầu với hương ngọt ngào từ cam bergamot và chút hương vị chua từ quả chanh vàng. Tầng hương giữa là sự hòa quyện hương thơm ngát của hoa diễn vĩ và hương thơm đặc trưng của hoa cam. Cuối cùng còn lưu lại là hương thơm ấm áp, nhẹ nhàng của cây hoắc hương và xạ hương. Tất cả tạo nên mùi hương đặc trưng cho Gucci Guilty Eau Pour Homme Nam Tính, Lịch Lãm và Lôi CuốnPhóng đãng, tươi mới đầy tài tình, Gucci Guilty Eau Pour Homme như viên nam châm, thu hút tất cả sự chú ý xung quanh về phía mình.', N'Nhóm nước hoa: Hương Gỗ thơm &#8211; Woody AromaticGiới tính: NamNăm ra mắt: 2015Nồng độ: Eau De Toilette (EDT)Phong cách: Nam Tính, Lịch Lãm, Lôi CuốnHương đầu: Quả chanh vàng, Cam Bergamot.
Hương giữa: Hoa diên vĩ (Orris), Hoa cam, .
Hương cuối: Cây hoắc hương, Xạ hương.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (32, 2, N'
	
	Burberry Her Blossom
	', 100000, 100, N'Burberry-Her-Blossom-6.jpg', 0, N'
									

Burberry Her Blossom được đánh giá là hương thơm tươi mát, thanh tao và tràn đầy sức sống, Burberry Her Blossom là một bức thư tình đến London nở rộ. Đi bộ qua những công viên ngập tràn ánh nắng và những con đường phủ đầy hoa, đó là hiện thân của thái độ của người London trong những ngày đầu tiên của mùa xuân, tinh thần cao.

Burberry Her Blossom gói gọn sự thanh ngọt đặc trưng của Cam quýt cùng ít vị cay nồng từ Tiêu hồng trong các nốt hương đầu, Burberry Her Blossom nhanh chóng cho ta thấy được sự năng động đầy cá tính của mình.
Cùng các tầng hương mang đầy hoa cỏ từ Hoa mận và Mẫu đơn, ta dường như có thể tưởng tượng được một vườn hoa mùa xuân bạt ngàn đủ màu được đem vào vỏn vẹn trọng Burberry Her Blossom.
Sau cùng, nàng có thể cảm nhận được sự ấm áp đến dễ chịu chạy dọc cơ thể với Bạch đàn hương, điểm xuyết thêm đường nét quyến rũ tự nhiên của Xạ hương.

							', N'
	Nhóm nước hoa: Hương hoa cỏ trái cây
Giới tính: Nữ
Năm ra mắt: 2018
Nồng độ: Eau De Toilette (EDT)
Độ toả hương: Gần – Trong vòng cánh tay
Phong Cách: Trẻ Trung, Nữ Tính, Nhẹ Nhàng
Hương đầu: Cam quýt, Hạt tiêu hồng
Hương giữa: Hoa mận, Hoa mẫu đơn
Hương cuối: Xạ hương, Gỗ đàn hương
')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (33, 2, N'
Gucci Guilty Pour Femme EDT', 100000, 100, N'Gucci-Guilty-Pour-Femme-EDT.jpg', 0, N'Nước Hoa Nữ Gucci Guilty Pour Femme EDT là chai nước hoa mới của Gucci thuộc dòng hương Amber Floral (hương hoa và hổ phách) đặc trưng. Sự nữ tính đến từ các loài hoa tử đinh hương. Tươi mát từ cam chanh. Và gợi cảm nhờ hổ phách cùng hoắc hương nồng đậm.Gucci Guilty Pour Femme EDT Với thân hình mảnh khảnh và gợi cảm, được bao bọc trong màu kim loại vàng và chiếc nắp chai xinh xắn, sự kết hợp không thể hoàn hảo hơn của dòng Gucci Guilty Pour Femme phù hợp với gu thẩm mỹ của những người phụ nữ tinh tế. Biểu tượng logo Gucci bằng vàng được đặt giữa thân chai, khiến tác phẩm trông càng nghệ thuật. Đơn giản nhưng tinh tế chai nước hoa khiến người nhìn thấy phải xao xuyến.Gucci Guilty Pour Femme EDT Mở đầu với hương thơm rạng rỡ của quýt Ý, hòa trộn với tiêu hồng, gợi lên một tầng hương tươi sáng và đầy sức sống. Sau đó là sự kết hợp của hoa tử đinh hương với hương vị ngon ngọt của những quả đào và mâm xôi, hoa phong lữ Ai Cập; mang đến sự tương phản tinh tế. Cuối cùng là sự kết hợp của hoắc hương và hổ phách nồng ấm. Mang hơi hướng kem sữa béo ngậy và quyến rũ', N'Nhóm nước hoa: Nhóm Hương Hoa CỏGiới tính: NữNăm ra mắt: 2021Nồng độ: Eau De Toilette (EDT)Phong cách: Quyến Rũ, Quý Phái, Gợi CảmHương Đầu: Quýt, Tiêu HồngHương Giữa: Quả Đào, Tử Đinh Hương, Hoa Nhài, Hoa Phong Lữ, Dâu Rừng, Nho ĐenHương Cuối: Xạ Hương Trắng, Hổ Phách, Vani, Hoắc Hương')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (34, 2, N'
Burberry Hero', 100000, 100, N'Burberry-Hero.jpg', 0, N'Trong năm 2021, hương thơm mới nhất của thương hiệu đình đám nước Anh &#8211; Burberry Hero vừa được giới thiệu với toàn thể công chúng, đánh dấu sự trở lại của nhà mốt trong lãnh địa mùi hương. Burberry cũng chính thức tung thêm chiến dịch cho Burberry Hero, nước hoa mới dành cho nam giới với sự tham gia của nam diễn viên được đề cử giải Oscar, Adam Driver.Một con người mới, một anh hùng mới. Burberry Hero &#8211; hương thơm tràn đầy tinh thần mạnh mẽ và sự nam tính của quý ông Burberry, một người không chỉ đam mê, thoả sức khám phá sự tự do như một chủ nghĩa anh hùng hiện đại. Với hương thơm mở đầu đầy tươi mát và ngập tràn sức sống của cam bergamot, hương thơm được tiếp thêm sinh lực với cây bách xù và hạt tiêu đen, đến cuối cùng lại trở nên sâu lắng với gỗ tuyết tùng.Burberry Hero đại diện cho sự hai mặt giữa sức mạnh và sự nhạy cảm. Một mùi hương đại diện cho sự vượt thời gian của Burberry và đồng thời mang đến cảm giác hiện đại. Một sự pha trộn giữa tính phổ quát và tính độc đáo. Mùi hương thể hiện thú tính bên trong mỗi người đàn ông bên cạnh một con người thực sự.', N'Nhóm nước hoa: Hương gỗ thơmGiới tính: NamNăm ra mắt: 2021Nồng độ: EDTPhong cách: Nam Tính, Mạnh Mẽ, Thu HútHương Đầu: Cam Bergamot;
hương Giữa: Cây Bách Xù và Tiêu Đen;
hương Cuối: Gỗ Tuyết Tùng  Atlas , Gỗ Tuyết Tùng Virginian và Gỗ Tuyết Tùng Himalayan')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (35, 2, N'
Amouage Interlude 53', 100000, 100, N'Amouage-Interlude-53.jpg', 0, N'Amouage Interlude 53  là Phiên bản mở rộng từ “Interlude Man”. Interlude 53 là thành quả biến đổi chậm rãi từ nguyên liệu nguyên bản, Amouage đã mất 6 tháng sau khi điều chế, mới chính thức đưa “Interlude 53” đến giới mộ điệu. Interlude 53 sở hữu lượng tinh dầu cao nhất nhất từ trước đến nay. Amouage vẫn trung thành công thức mang nguyên tố “Di Sản” Oman tuyệt mĩ, cộng hưởng kỹ xảo chế tác tráng thuỷ tinh trong suốt làm nên đẳng cấp bất biến.Amouage Interlude 53 mới được tạo ra để đưa vũ trụ Interlude lên một cấp độ khác. Thành phần dựa trên công thức ban đầu, nhưng được pha chế với 53% nồng độ nước hoa khổng lồ, mang lại một nốt hương hài hòa cho điểm ban đầu.Đọc thêm về những ý tưởng trước khi ra mắt lần này trong cuộc phỏng vấn độc quyền của chúng tôi với Renaud Salmon: “Ở ngã tư của sự tập trung cao độ và quá trình lão hóa kéo dài, một phiên bản bổ sung tuyệt vời của một trong những sáng tạo mang tính biểu tượng nhất của Amouage – Interlude Man – hiện được bào chế với liều lượng 53% và được ủ trong 6 tháng tại nhà máy của chúng tôi ở Muscat, tiết lộ những khía cạnh và chiều sâu tiềm ẩn của hình thức ban đầu của nó. Nơi Interlude Man là sự hỗn loạn đầy màu sắc, thì sự trưởng thành của Amouage Interlude 53 truyền đi sự hoàn chỉnh và hài hòa hơn”', N'Nhóm nước hoa: Nhóm Hương Amber WoodyGiới tính: UnisexNăm ra mắt: 2021Nồng độ: Extrait De ParfumNhà pha chế: Pierre NegrinĐộ lưu hương: Lâu Trên 12 giờĐộ toả hương: Xa – bán kính trên 2mPhong cách: Ấm áp, Nam Tính, Mạnh MẽHương đầu: Cam Bergamot, Oregano, Ớt anh đào
Hương giữa: Hổ phách, Nhũ hương, Nhựa Thơm
Hương cuối: Da thuộc, Khói trầm hương, Cây hoắc hương, Gỗ đàn hương')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (36, 2, N'
Son Tom Ford 16 Scarlet Rouge Scented Limited Màu Đỏ Thuần', 100000, 100, N'Son-Tom-Ford-Lip-Color-Limited-Edition-16-Scarlet-Rouge-Mau-Do-Thuan.jpg', 0, N'Son Tom Ford 16 Scarlet Rouge Scented Limited Màu Đỏ Thuần làm ai yêu son đều phải &#8220;đắm đuối&#8221; ngay từ cái nhìn đầu tiên. Tom Ford 16 Scarlet Rouge vỏ đỏ có màu đỏ hơi trầm một chút cổ điển đánh trực tiếp lên môi, chỉ với một đường cơ bản màu của son lên đã rất sáng và chuẩn. Hơn thế, son thuộc dòng satin có pha 1 chút dưỡng giúp môi không bị khô khi sử dụng.Thiết kế son Tom Ford 16 Scarlet Rouge LimitedSon Tom Ford 16 Scarlet Rouge Scented Limited màu đỏ thuần có màu đỏ hơi trầm một chút cổ điển đánh trực tiếp lên môi, chỉ với một đường cơ bản màu của son lên đã rất sáng và chuẩn. Đợi một vài phút, cho màu tự nhiên và xinh xắn lắm các Nàng nhé.Chất son mềm mượt, đầy đặn, không khô môi, lên màu siêu chuẩn đây cũng là đặc điểm khác biệt của cây son lì Tom Ford so với các dòng son hiện nay.Màu son Tom Ford 16 Scarlet Rouge LimitedTom Ford Limited Edition 16 Scarlet Rouge màu đỏ thuần có màu đỏ hơi trầm một chút cổ điển đánh trực tiếp lên môi, chỉ với một đường cơ bản màu của son lên đã rất sáng và chuẩn. Đợi một vài phút, cho màu tự nhiên và xinh xắn lắm các Nàng nhé.Chất son mềm mượt, đầy đặn, không khô môi, lên màu siêu chuẩn đây cũng là đặc điểm khác biệt của cây son lì Tom Ford so với các dòng son hiện nay.Nếu từng “phát cuồng” vì son đỏ thì Son Tom Ford 16 Scarlet Rouge Scented Limited chính xác là điều mà các nàng đang tìm kiếm. Son đỏ rực rỡ tạo hiệu ứng lấp lánh và thu hút hơn cho đôi môi. Riêng với son Tom Ford Limited Edition 16 Scarlet Rouge này thì tôn da bất chấp rồi. Da trắng, da ngăm, da trung bình ngăm đều “biến hóa” được tất tần tật. Dù là một cô nàng yêu kiều, điệu đà hay chuẩn xác là it girls cá tính đều chẳng thể cưỡng lại sức hút của thỏi Tom Ford ăn khách này.', N'Nhãn hiệu: Tom FordPhân Loại: Son LìMầu Sắc: Đỏ ThuầnKhả năng bám mầu: 5 – 6h đồng hồTrọng Lượng: 3.5g')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (37, 2, N'
Burberry Her London Dream', 100000, 100, N'Burberry-Her-London-Dream.jpg', 0, N'Her London Dream EDP là một phiên bản hoàn toàn mới được ra mắt vào năm 2020 của thương hiệu đình đáp Burberry. Her London Dream là sự diễn tả hành trình đầy lãng mạng của cô gái đến với trung tâm thành phố London tráng lệ. Người tạo nên mùi hương đặc biệt này đó là Jerome Di Marino và Maïa Lernout.Mùi hương của Her London Dream là mùi hương dành cho những cô gái có tính cách phóng khoáng, sôi nổi với trái tim đầy lãng mạn. Đó là một sự kết hợp mùi hương dễ gây nghiện với chanh, gừng ngay từ những nốt hương đầu tiên. Hương thơm được nâng lên đầy lãng mạng với hoa mẫu đơn và hoa hồng  được bao lấy bởi sự mộng mơ của hổ phách và xạ hương ở nốt hương cuối.Burberry Her London Dream mang những giấc mơ hoàn mỹ cũng như niềm khao khát về một tình yêu đầy hứa hẹn. Mở ra một cuộc đối ngẫu hoàn chính giữa 2 cá thể chanh và gừng khiến mùi hương gây những ấn tượng đặc biệt ở ngay những lần đầu tiên. Tiếp theo, Burberry Her London Dream lại tập trung tạo nên những phong cách nữ tính đầy táo bạo, hoa hồng mang biểu trưng cho một khao khát về tình yêu lãng mạn trong khi hoa mẫu đơn lại mang những hình ảnh về sự cá tính đầy yểu điểu nhưng không sặc sỡ. Cuối cùng, như bao lần tỏa hương khác, xạ hương lại xuất hiện một cách bình dị hòa cùng hổ phách khiến tổng thể của Burberry Her London Dream mang đậm chất duy mỹ và nền nã.', N'Nhóm nước hoa: Nhóm Hương Floral ( Hương Hoa, Phấn Thơm )Giới tính: NữNăm ra mắt: 2020Nồng độ: Eau De ParfumNhà pha chế: Jerome Di Marino và Maïa Lernout.Độ lưu hương: 4 giờ đến 6 giờĐộ toả hương: Trong vòng 1 cánh tayPhong cách: Thanh Lịch, Sang Trọng, Quyến RũHương Đầu: Chanh, Gừng
Hương Giữa: Hoa Mẫu Đơn, Hoa Hồng.
Hương Cuối: Xạ Hương, Hổ Phách.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (38, 2, N'
Kilian Princess Rose De Mai', 100000, 100, N'Kilian-Princess-Rose-De-Ma-7.jpg', 0, N'Kilian Princess Rose De Mai là một mùi hương mới đến từ thương hiệu nước hoa Niche nổi tiếng Kilian, được cho ra mắt năm 2019 và người đứng sau mùi hương này là Honorine Blanc. Với khẩu hiệu “I Don’t Need A Prince By My Side To Be A Princess” được in nổi trên nắp chai, Princess Rose De Mai mang đến thông điệp cho toàn phái đẹp về sự độc lập, tự chủ và luôn xinh đẹp vì “Không cần một hoàng tử đi bên cạnh, tự em đã có thể là công chúa”.Kilian Princess Rose De Mai với thiết kế lần vô cùng đặc biệt và bắt mắt với thân chai là hình quả cầu màu vàng đồng sang trọng,đi cùng là nắp chai vuông vức kèm dòng chữ “I Don’t Need A Prince By My Side To Be A Princess”  được dập nổi tinh tế như muốn nhấn mạnh ý nghĩa mà chai nước hoa này muốn truyền tải đến mọi người.Hoa hồng &#8211; Nữ hoàng của những loài hoa đã khoác lên mình chiếc áo Kilian sang trọng, kiêu kỳ rồi lan sự toả sự cám dỗ đầy mê hoặc ở mọi khía cạnh của không gian. Để thêm phần lôi cuốn, Nàng đã khéo léo lồng ghép vị cay nhè nhẹ của Gừng và hương thơm tươi mát, sảng khoái của Matcha để tạo nên một không gian lãng mạn, ấm áp khiến ai cũng muốn được tựa vào.', N'Nhóm nước hoa: Oriental Vanilla (Hương Thơm Vani Ngọt Ngào)Giới tính: NữNăm ra mắt: 2019Nồng độ: Eau De Parfum (EDP)Độ lưu hương: 7 giờ đến 12 giờĐộ toả hương: Xa &#8211; Trên 2mPhong cách: Lãng Mạng, Quyến Rũ, Sang TrọngHương đầu: Gừng.Hương giữa: Hoa hồng Bungari, Hoa hồng.Hương cuối: Trà xanh, Kẹo marshmallow.')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (39, 2, N'
Diesel Spirit Of The Brave', 100000, 100, N'Diesel-Spirit-Of-The-Brave-8.jpg', 0, N'Tiếp nối serie dòng nước hoa với thiết kế tay đấm sắt độc đáo, thương hiệu Diesel tiếp tục cho ra mắt mùi hương mới với tên gọi Diesel Spirit Of The Brave. Chai nước hoa với tone màu đen vàng sang trọng cùng hoạ tiết mặt hổ cá tính thể hiện bản lĩnh phái mạnh.Diesel Spirit Of The Brave giúp phái mạnh thể hiện sự tự tin, mạnh mẽ đầy chủ động, được phân loại thuộc nhóm hương thơm hương gỗ cay nồng. Nước hoa này được lấy cảm hứng từ ý tưởng của việc biết bạn là ai và những điều mà bạn tin tưởng, và bạn có đủ can đảm để sử dụng niềm tin đó lên làn da của bạn mãi mãi.Diesel Spirit Of The Brave bắt đầu với hương thơm nam tính và mạnh mẽ của da thuộc. Hương thơm của chanh, các mùi hương của sự tươi mới, cộng với gỗ và hương hổ phách cùng với tuyết tùng mang lại cảm giác thoải mái cho người dùng. Mang lại cho phái mạnh vẻ ngoài bụi bặm một cách đầy nam tính và hấp dẫn với mùi hương trầm ấm và rất dễ gần.', N'Nhóm nước hoa: Nhóm Hương Amber WoodGiới tính: NamNăm ra mắt: 2019Nồng độ: Eau De Toilette (EDT)Độ lưu hương: 4 giờ đến 6 giờĐộ toả hương: Bán Kính 1,5mPhong cách: Táo Bạo, Mạnh Mẽ, Nồng NhiệtHương đầu: Quả quýt hồng, Quả chanh vàng Amalfi.Hương giữa: Hoa tím, Gỗ tuyết tùng, Virginia, Ngò thơm.Hương cuối: Hương Labdanum Pháp, Hổ phách, Bồ đề, Da thuộc, An tức hương')
INSERT [dbo].[Product] ([IDProduct], [IDCategory], [Name], [Price], [Stock], [ImageURL], [IsDelete], [Description], [ShortDescription]) VALUES (40, 2, N'
Diesel Fuel For Life Pour Homme', 100000, 100, N'Diesel-Fuel-For-Life-for-men.jpg', 0, N'Với thiết kế hoang dã độc đáo cùng vải bố bọc lấy thân chai, Diesel Fuel For Life với nghĩa tiếng Việt là “Nguồn nhiên liệu cho cuộc sống”, trong hơn 10 năm qua đã là một item không-thể-thiếu cho các bộ sưu tập mùi hương của chàng bởi vẻ đẹp năng động đầy nhiệt huyết của mình.Dưới bàn tay tác chế của Annick Mernado cùng Jacques Cavallier, Diesel Fuel For Life với tông hương đầu mở ra với nét ngọt mát ấn tượng từ Bưởi, điểm nhấn chút mềm cay với Hoa hồi. Sự tươi tắn len lỏi trong từng nốt hương, dẫn dắt ta đến với Dâu rừng mọng nước, hòa quyện tinh tế đến thanh tao với Oải hương, tạo ra cảm giác bồng bềnh, lửng lơ giữa cánh rừng nhiệt đới bát ngát hoa và trái.Phóng khoáng nhưng đầy kiêu hãnh, tầng hương cuối mở ra như một bản độc tấu giữa Hương gỗ cùng Hoa vòi voi, hương thơm tự tin, sôi động bừng sáng tựa như nụ cười mê hoặc đầy ẩn ý của những chàng trai nổi loạn đầy tinh tế.', N'Nhóm nước hoa: Hương Dương Sỉ Phương ĐôngGiới tính: NamNăm ra mắt: 2007Nồng độ: Eau De Toilette (EDT)Nhà pha chế: Annick Mernado, Jacques CavallierĐộ lưu hương: 6 giờ đến 8 giờĐộ toả hương: trong vòng 1 cánh tayPhong cách: Tự Tin, Lôi Cuốn, Nam TínhHương đầu: Bưởi, Hoa hồi
Hương giữa: Oải hương, Dâu rừng
Hương cuối: Hương gỗ, Hoa vòi voi')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[AccountAddress]  WITH CHECK ADD FOREIGN KEY([IDAccount])
REFERENCES [dbo].[Account] ([IDAccount])
GO
ALTER TABLE [dbo].[AccountAddress]  WITH CHECK ADD FOREIGN KEY([IDAddress])
REFERENCES [dbo].[Address] ([IDAddress])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([IDAccount])
REFERENCES [dbo].[Account] ([IDAccount])
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([IDAddress])
REFERENCES [dbo].[Address] ([IDAddress])
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([IDCart])
REFERENCES [dbo].[Cart] ([IDCart])
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([IDStatus])
REFERENCES [dbo].[Status] ([IDStatus])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([IDCategory])
REFERENCES [dbo].[Category] ([IDCategory])
GO
ALTER TABLE [dbo].[ProductCart]  WITH CHECK ADD FOREIGN KEY([IDCart])
REFERENCES [dbo].[Cart] ([IDCart])
GO
ALTER TABLE [dbo].[ProductCart]  WITH CHECK ADD FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Product] ([IDProduct])
GO
ALTER TABLE [dbo].[StaffRole]  WITH CHECK ADD FOREIGN KEY([IDRole])
REFERENCES [dbo].[Role] ([IDRole])
GO
ALTER TABLE [dbo].[StaffRole]  WITH CHECK ADD FOREIGN KEY([IDStaff])
REFERENCES [dbo].[AccountStaff] ([IDStaff])
GO
USE [master]
GO
ALTER DATABASE [Scent] SET  READ_WRITE 
GO
