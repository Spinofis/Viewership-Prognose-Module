using AutoMapper;
using DatabaseProject.DbModel;
using DatabaseProject.DtoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseProject.DbLogic
{
    public class DbLogic
    {
        public ICollection<ProgramTypeDTO> GetProgramTypes()
        {
            using (var context = new Model())
            {
                var obj = (from prt in context.Program_type
                           select prt).ToList();

                return Mapper.Map<ICollection<Program_type>, ICollection<ProgramTypeDTO>>(obj);
            }
        }

        public ProgramTypeDTO SaveProgramType(ProgramTypeDTO programTypeDTO)
        {
            using (var context = new Model())
            {
                Program_type program_Type = Mapper.Map<ProgramTypeDTO, Program_type>(programTypeDTO);
                context.Program_type.Add(program_Type);
                context.SaveChanges();
                programTypeDTO.Id = program_Type.prt_id;
                return programTypeDTO;
            }
        }
    }
}
