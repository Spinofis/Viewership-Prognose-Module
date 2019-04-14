namespace DatabaseProject.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<DatabaseProject.DbModel.Model2>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
            ContextKey = "DatabaseProject.DbModel.Model";
        }

        protected override void Seed(DatabaseProject.DbModel.Model2 context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data.
        }
    }
}
