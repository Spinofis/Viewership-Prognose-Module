namespace DatabaseProject.DbModel
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class Model2 : DbContext
    {
        public Model2()
            : base("name=Model2")
        {
        }

        public virtual DbSet<Channels> Channels { get; set; }
        public virtual DbSet<Program_tv> Program_tv { get; set; }
        public virtual DbSet<Program_type> Program_type { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Channels>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Channels>()
                .Property(e => e.program_url)
                .IsUnicode(false);

            modelBuilder.Entity<Channels>()
                .HasMany(e => e.Program_tv)
                .WithOptional(e => e.Channels)
                .HasForeignKey(e => e.id_chan);

            modelBuilder.Entity<Program_tv>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Program_type>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Program_type>()
                .HasMany(e => e.Program_tv)
                .WithOptional(e => e.Program_type)
                .HasForeignKey(e => e.id_prg_type);
        }
    }
}
