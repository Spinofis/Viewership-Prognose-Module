using AutoMapper;
using ImportTvGuide.DbModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ImportTvGuide
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
