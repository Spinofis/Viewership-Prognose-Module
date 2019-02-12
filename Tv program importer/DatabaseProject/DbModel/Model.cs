namespace DatabaseProject.DbModel
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class Model : DbContext
    {
        public Model()
            : base("name=Model1")
        {
        }

        public virtual DbSet<Program_tv> Program_tv { get; set; }
        public virtual DbSet<Program_type> Program_type { get; set; }
        public virtual DbSet<Station> Station { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<Weather> Weather { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Program_tv>()
                .Property(e => e.pr_name)
                .IsUnicode(false);

            modelBuilder.Entity<Program_type>()
                .Property(e => e.prt_name)
                .IsUnicode(false);

            modelBuilder.Entity<Program_type>()
                .HasMany(e => e.Program_tv)
                .WithRequired(e => e.Program_type)
                .HasForeignKey(e => e.pr_prt_id)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Station>()
                .Property(e => e.sta_name)
                .IsUnicode(false);

            modelBuilder.Entity<Station>()
                .HasMany(e => e.Program_tv)
                .WithRequired(e => e.Station)
                .HasForeignKey(e => e.pr_sta_id)
                .WillCascadeOnDelete(false);
        }
    }
}
