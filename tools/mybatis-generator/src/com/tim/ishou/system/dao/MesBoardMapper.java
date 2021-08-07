package com.tim.ishou.system.dao;

import com.tim.ishou.system.po.MesBoard;
import com.tim.ishou.system.po.MesBoardExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface MesBoardMapper {
    int countByExample(MesBoardExample example);

    int deleteByExample(MesBoardExample example);

    int deleteByPrimaryKey(String id);

    int insert(MesBoard record);

    int insertSelective(MesBoard record);

    List<MesBoard> selectByExample(MesBoardExample example);

    MesBoard selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") MesBoard record, @Param("example") MesBoardExample example);

    int updateByExample(@Param("record") MesBoard record, @Param("example") MesBoardExample example);

    int updateByPrimaryKeySelective(MesBoard record);

    int updateByPrimaryKey(MesBoard record);
}