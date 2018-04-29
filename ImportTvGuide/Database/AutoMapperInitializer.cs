using AutoMapper;
using DatabaseProject.DbModel;
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
                //cfg.CreateMap<Program_type, Program_typeDTO>();
                //cfg.CreateMap<Weather, WeatherDTO>();
            });
        }
    }
}
