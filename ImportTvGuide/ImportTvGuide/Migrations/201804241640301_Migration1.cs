namespace ImportTvGuide.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Migration1 : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Weather", "we_da_id");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Weather", "we_da_id", c => c.Int(nullable: false));
        }
    }
}
