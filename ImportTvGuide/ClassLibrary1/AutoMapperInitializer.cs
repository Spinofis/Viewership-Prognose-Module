using AutoMapper;
using DatabaseProject.DbModel;
using DatabaseProject.DtoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseProject
{
    public static class AutoMapperInitializer
    {


        public static void InitializeMapping()
        {
            Mapper.Initialize(cfg =>
            {
                //cfg.CreateMap<ProgramTV, ProgramTvDTO>();
                cfg.CreateMap<Program_type, ProgramTypeDTO>();
                //cfg.CreateMap<Weather, WeatherDTO>();
            });
        }
    }
}
