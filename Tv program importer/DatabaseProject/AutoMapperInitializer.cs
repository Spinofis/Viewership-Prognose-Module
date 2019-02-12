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
                cfg.CreateMap<ProgramTypeDTO, Program_type>().
                ForMember(dest => dest.prt_name, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.prt_id, opt => opt.MapFrom(src => src.Id));

                cfg.CreateMap<Program_type, ProgramTypeDTO>().
              ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.prt_name))
              .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.prt_id));
                //cfg.CreateMap<Weather, WeatherDTO>();
            });
        }
    }
}
