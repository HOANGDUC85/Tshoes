﻿// <auto-generated />
using System;
using FCSP.Models.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace FCSP.Models.Migrations
{
    [DbContext(typeof(FcspDbContext))]
    partial class FcspDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "9.0.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("FCSP.Models.Entities.CustomShoeDesign", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("CustomShoeDesignTemplateId")
                        .HasColumnType("bigint");

                    b.Property<string>("DesignData")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Preview3DFileUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal?>("Price")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.HasIndex("CustomShoeDesignTemplateId");

                    b.HasIndex("UserId");

                    b.ToTable("CustomShoeDesigns");
                });

            modelBuilder.Entity("FCSP.Models.Entities.CustomShoeDesignTemplate", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal?>("Price")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("CustomShoeDesignTemplates");
                });

            modelBuilder.Entity("FCSP.Models.Entities.CustomShoeDesignTexture", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("CustomShoeDesignId")
                        .HasColumnType("bigint");

                    b.Property<long?>("TextureId")
                        .HasColumnType("bigint");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("CustomShoeDesignId");

                    b.HasIndex("TextureId");

                    b.ToTable("CustomShoeDesignTextures");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Order", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<decimal?>("AmountPaid")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("ShippingInfoId")
                        .HasColumnType("bigint");

                    b.Property<int?>("ShippingStatus")
                        .HasColumnType("int");

                    b.Property<int>("Status")
                        .HasColumnType("int");

                    b.Property<decimal?>("TotalPrice")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.HasIndex("ShippingInfoId");

                    b.HasIndex("UserId");

                    b.ToTable("Orders");
                });

            modelBuilder.Entity("FCSP.Models.Entities.OrderDetail", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("CustomShoeDesignId")
                        .HasColumnType("bigint");

                    b.Property<long?>("OrderId")
                        .HasColumnType("bigint");

                    b.Property<decimal?>("Price")
                        .HasColumnType("decimal(18,2)");

                    b.Property<int>("Quantity")
                        .HasColumnType("int");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("CustomShoeDesignId");

                    b.HasIndex("OrderId");

                    b.ToTable("OrderDetails");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Payment", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<decimal>("Amount")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("OrderId")
                        .HasColumnType("bigint");

                    b.Property<int>("PaymentMethod")
                        .HasColumnType("int");

                    b.Property<int>("PaymentStatus")
                        .HasColumnType("int");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("OrderId");

                    b.ToTable("Payments");
                });

            modelBuilder.Entity("FCSP.Models.Entities.PaymentGateway", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int>("PaymentMethod")
                        .HasColumnType("int");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("PaymentGateways");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Post", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Title")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Posts");
                });

            modelBuilder.Entity("FCSP.Models.Entities.PostComment", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<string>("Comment")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("PostId")
                        .HasColumnType("bigint");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.HasIndex("PostId");

                    b.HasIndex("UserId");

                    b.ToTable("PostComments");
                });

            modelBuilder.Entity("FCSP.Models.Entities.ShippingInfo", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<string>("City")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Country")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("District")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("StreetAddress")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.Property<string>("Ward")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("ShippingInfos");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Texture", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("Price")
                        .HasColumnType("int");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Textures");
                });

            modelBuilder.Entity("FCSP.Models.Entities.User", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<long>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<long?>("DefaultAddressId")
                        .HasColumnType("bigint");

                    b.Property<long?>("DefaultAddressId1")
                        .HasColumnType("bigint");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PasswordHash")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int>("UserRole")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("DefaultAddressId1");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("FCSP.Models.Entities.CustomShoeDesign", b =>
                {
                    b.HasOne("FCSP.Models.Entities.CustomShoeDesignTemplate", "CustomShoeDesignTemplate")
                        .WithMany("CustomShoeDesigns")
                        .HasForeignKey("CustomShoeDesignTemplateId");

                    b.HasOne("FCSP.Models.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId");

                    b.Navigation("CustomShoeDesignTemplate");

                    b.Navigation("User");
                });

            modelBuilder.Entity("FCSP.Models.Entities.CustomShoeDesignTemplate", b =>
                {
                    b.HasOne("FCSP.Models.Entities.User", null)
                        .WithMany("ShoeDisplays")
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("FCSP.Models.Entities.CustomShoeDesignTexture", b =>
                {
                    b.HasOne("FCSP.Models.Entities.CustomShoeDesign", "CustomShoeDesign")
                        .WithMany("CustomShoeDesignTextures")
                        .HasForeignKey("CustomShoeDesignId");

                    b.HasOne("FCSP.Models.Entities.Texture", "Texture")
                        .WithMany("CustomShoeDesignTextures")
                        .HasForeignKey("TextureId");

                    b.Navigation("CustomShoeDesign");

                    b.Navigation("Texture");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Order", b =>
                {
                    b.HasOne("FCSP.Models.Entities.ShippingInfo", "ShippingInfo")
                        .WithMany()
                        .HasForeignKey("ShippingInfoId");

                    b.HasOne("FCSP.Models.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId");

                    b.Navigation("ShippingInfo");

                    b.Navigation("User");
                });

            modelBuilder.Entity("FCSP.Models.Entities.OrderDetail", b =>
                {
                    b.HasOne("FCSP.Models.Entities.CustomShoeDesign", "CustomShoeDesign")
                        .WithMany()
                        .HasForeignKey("CustomShoeDesignId");

                    b.HasOne("FCSP.Models.Entities.Order", "Order")
                        .WithMany("OrderDetails")
                        .HasForeignKey("OrderId");

                    b.Navigation("CustomShoeDesign");

                    b.Navigation("Order");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Payment", b =>
                {
                    b.HasOne("FCSP.Models.Entities.Order", "Order")
                        .WithMany("Payments")
                        .HasForeignKey("OrderId");

                    b.Navigation("Order");
                });

            modelBuilder.Entity("FCSP.Models.Entities.PaymentGateway", b =>
                {
                    b.HasOne("FCSP.Models.Entities.User", "User")
                        .WithMany("PaymentGateways")
                        .HasForeignKey("UserId");

                    b.Navigation("User");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Post", b =>
                {
                    b.HasOne("FCSP.Models.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId");

                    b.Navigation("User");
                });

            modelBuilder.Entity("FCSP.Models.Entities.PostComment", b =>
                {
                    b.HasOne("FCSP.Models.Entities.Post", "Post")
                        .WithMany("PostComments")
                        .HasForeignKey("PostId");

                    b.HasOne("FCSP.Models.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId");

                    b.Navigation("Post");

                    b.Navigation("User");
                });

            modelBuilder.Entity("FCSP.Models.Entities.ShippingInfo", b =>
                {
                    b.HasOne("FCSP.Models.Entities.User", "User")
                        .WithMany("ShippingInfos")
                        .HasForeignKey("UserId");

                    b.Navigation("User");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Texture", b =>
                {
                    b.HasOne("FCSP.Models.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId");

                    b.Navigation("User");
                });

            modelBuilder.Entity("FCSP.Models.Entities.User", b =>
                {
                    b.HasOne("FCSP.Models.Entities.ShippingInfo", "DefaultAddress")
                        .WithMany()
                        .HasForeignKey("DefaultAddressId1");

                    b.Navigation("DefaultAddress");
                });

            modelBuilder.Entity("FCSP.Models.Entities.CustomShoeDesign", b =>
                {
                    b.Navigation("CustomShoeDesignTextures");
                });

            modelBuilder.Entity("FCSP.Models.Entities.CustomShoeDesignTemplate", b =>
                {
                    b.Navigation("CustomShoeDesigns");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Order", b =>
                {
                    b.Navigation("OrderDetails");

                    b.Navigation("Payments");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Post", b =>
                {
                    b.Navigation("PostComments");
                });

            modelBuilder.Entity("FCSP.Models.Entities.Texture", b =>
                {
                    b.Navigation("CustomShoeDesignTextures");
                });

            modelBuilder.Entity("FCSP.Models.Entities.User", b =>
                {
                    b.Navigation("PaymentGateways");

                    b.Navigation("ShippingInfos");

                    b.Navigation("ShoeDisplays");
                });
#pragma warning restore 612, 618
        }
    }
}
