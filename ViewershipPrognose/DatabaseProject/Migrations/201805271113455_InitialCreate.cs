namespace DatabaseProject.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Program_tv",
                c => new
                    {
                        pr_id = c.Int(nullable: false),
                        pr_prt_id = c.Int(nullable: false),
                        pr_sta_id = c.Int(nullable: false),
                        pr_name = c.String(maxLength: 100, unicode: false),
                        pr_start_date = c.DateTime(),
                        pr_end_date = c.DateTime(),
                        aud_data = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.pr_id)
                .ForeignKey("dbo.Program_type", t => t.pr_prt_id)
                .ForeignKey("dbo.Station", t => t.pr_sta_id)
                .Index(t => t.pr_prt_id)
                .Index(t => t.pr_sta_id);
            
            CreateTable(
                "dbo.Program_type",
                c => new
                    {
                        prt_id = c.Int(nullable: false),
                        prt_name = c.String(maxLength: 100, unicode: false),
                        aud_data = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.prt_id);
            
            CreateTable(
                "dbo.Station",
                c => new
                    {
                        sta_id = c.Int(nullable: false),
                        sta_name = c.String(maxLength: 100, unicode: false),
                        aud_data = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.sta_id);
            
            CreateTable(
                "dbo.sysdiagrams",
                c => new
                    {
                        diagram_id = c.Int(nullable: false, identity: true),
                        name = c.String(nullable: false, maxLength: 128),
                        principal_id = c.Int(nullable: false),
                        version = c.Int(),
                        definition = c.Binary(),
                    })
                .PrimaryKey(t => t.diagram_id);
            
            CreateTable(
                "dbo.Weather",
                c => new
                    {
                        we_id = c.Int(nullable: false),
                        we_temperature = c.Double(),
                        we_wind_speed = c.Double(),
                        we_start_date = c.DateTime(),
                        we_end_date = c.DateTime(),
                        aud_date = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.we_id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Program_tv", "pr_sta_id", "dbo.Station");
            DropForeignKey("dbo.Program_tv", "pr_prt_id", "dbo.Program_type");
            DropIndex("dbo.Program_tv", new[] { "pr_sta_id" });
            DropIndex("dbo.Program_tv", new[] { "pr_prt_id" });
            DropTable("dbo.Weather");
            DropTable("dbo.sysdiagrams");
            DropTable("dbo.Station");
            DropTable("dbo.Program_type");
            DropTable("dbo.Program_tv");
        }
    }
}
