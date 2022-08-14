/*
 Navicat Premium Data Transfer

 Source Server         : DESARROLLO-LOCAL
 Source Server Type    : MySQL
 Source Server Version : 100419
 Source Host           : localhost:3306
 Source Schema         : sistem

 Target Server Type    : MySQL
 Target Server Version : 100419
 File Encoding         : 65001

 Date: 14/08/2022 17:31:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_personas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_personas`;
CREATE TABLE `tbl_personas`  (
  `IdPersona` bigint(20) NOT NULL AUTO_INCREMENT,
  `TipoIdentificacion` varchar(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `Identificacion` varchar(13) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `Nombres` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `Apellidos` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaNacimiento` date NULL DEFAULT NULL,
  `TelefonoConvencional` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `TelefonoCelular` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `Correo` varchar(150) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `Direccion` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `PathImagen` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  `Estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `UsuarioCrea` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaCrea` datetime(0) NULL DEFAULT NULL,
  `UsuarioActualiza` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaActualiza` datetime(0) NULL DEFAULT NULL,
  `UsuarioElimina` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaElimina` datetime(0) NULL DEFAULT NULL,
  `Sexo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`IdPersona`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_personas
-- ----------------------------
INSERT INTO `tbl_personas` VALUES (1, 'C', '09401645254', 'Admin', 'Isagentech', '1997-02-23', '0000000000', '099999999', 'admin@isagentech.com', 'Ecuador', '', 'A', 'batch', '2022-01-23 12:51:25', 'batch', '2022-04-04 17:39:25', NULL, NULL, 'M');

-- ----------------------------
-- Table structure for tbl_roles
-- ----------------------------
DROP TABLE IF EXISTS `tbl_roles`;
CREATE TABLE `tbl_roles`  (
  `IdRol` int(11) NOT NULL AUTO_INCREMENT,
  `Rol` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `Descripcion` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `Estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `UsuarioCrea` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaCrea` datetime(0) NULL DEFAULT NULL,
  `UsuarioActualiza` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaActualiza` datetime(0) NULL DEFAULT NULL,
  `UsuarioElimina` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaElimina` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`IdRol`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_roles
-- ----------------------------
INSERT INTO `tbl_roles` VALUES (1, 'Administrador', 'Gestiona todas las operaciones del sistema', 'A', 'batch', '2022-01-23 12:43:49', 'batch', '2022-02-11 16:01:43', NULL, NULL);

-- ----------------------------
-- Table structure for tbl_usuarios
-- ----------------------------
DROP TABLE IF EXISTS `tbl_usuarios`;
CREATE TABLE `tbl_usuarios`  (
  `IdUsuario` bigint(20) NOT NULL AUTO_INCREMENT,
  `IdRol` int(11) NULL DEFAULT NULL,
  `IdPersona` bigint(20) NULL DEFAULT NULL,
  `Usuario` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `Clave` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  `ClaveTemp` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  `Estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `UsuarioCrea` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaCrea` datetime(0) NULL DEFAULT NULL,
  `UsuarioActualiza` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaActualiza` datetime(0) NULL DEFAULT NULL,
  `UsuarioElimina` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `FechaElimina` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`IdUsuario`) USING BTREE,
  INDEX `fk_idRolUsuario`(`IdRol`) USING BTREE,
  INDEX `fk_idPersonaUsuario`(`IdPersona`) USING BTREE,
  CONSTRAINT `fk_idPersonaUsuario` FOREIGN KEY (`IdPersona`) REFERENCES `tbl_personas` (`IdPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_idRolUsuario` FOREIGN KEY (`IdRol`) REFERENCES `tbl_roles` (`IdRol`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_usuarios
-- ----------------------------
INSERT INTO `tbl_usuarios` VALUES (1, 1, 1, 'admin', '$2a$10$Z43O8z7nEPu.l7S/mOsUzO0ViCyiuIL1g1Vin.OSE1QvOr5RqMt4W', NULL, 'A', 'batch', '2022-01-23 12:52:03', 'batch', '2022-04-04 17:39:25', NULL, NULL);

-- ----------------------------
-- Procedure structure for sp_autenticacion_crud
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_autenticacion_crud`;
delimiter ;;
CREATE PROCEDURE `sp_autenticacion_crud`(opcion_ int,
   IdUsuario_ bigint,
	 Usuario_ varchar(50),
	 Correo_ varchar(150),
	 Clave_ text)
begin


   /* seccion para retornar algun error que se pueda generar  en la transaccion */
	 /*=======================================================================================*/
			 declare exit HANDLER for SQLEXCEPTION
			 begin
					get diagnostics CONDITION 1 @p1 = RETURNED_SQLSTATE,@p2 = MESSAGE_TEXT;				 
					select @p1 as CodigoError , @p2 as MensajeError;	
					
			 end;
	 /*=======================================================================================*/			
 

		/*
		Estados de usuario

		A ->Activo
		I ->Inactivo
		X ->Enviar clave nueva
		R ->Clave Reseteada
		E ->Eliminado

		*/
		
		/*para el login*/
		if opcion_ = 1 then	    
				
				select '0000' as CodigoError , 'Transaccion Exitosa' as MensajeError;
				
				select 
					per.IdPersona, 
					usr.IdUsuario, 
					usr.Usuario,	
					rol.IdRol,
					rol.Rol,
					usr.Estado as Estado,
					usr.Clave,
					usr.ClaveTemp
				from tbl_personas per inner join tbl_usuarios usr on per.IdPersona = usr.IdPersona
				inner join tbl_roles rol on rol.IdRol = usr.IdRol 
				where 				 
					per.Estado = 'A' and
					rol.Estado = 'A' and 
		      usr.Usuario = Usuario_ ;
					
		end if;
		
    /*para extraer info del usuario logeado*/
		if opcion_ = 2 then 
				
				select '0000' as CodigoError , 'Transaccion Exitosa' as MensajeError;
				
				select 
					a.IdPersona,
					a.TipoIdentificacion,
					a.Identificacion,
					a.Sexo,
					a.Nombres,
					a.Apellidos,
					DATE_FORMAT(a.FechaNacimiento, "%Y-%m-%d") as FechaNacimiento,
					a.TelefonoConvencional,
					a.TelefonoCelular,
					a.Correo,
					a.Direccion,
					a.PathImagen,
					a.Estado as EstadoPersona,
					b.IdRol,
					r.Rol,
					b.IdUsuario,
					b.Usuario,
					b.Estado as EstadoUsuario,
					b.Estado as Estado
			from tbl_personas a inner join tbl_usuarios b on a.IdPersona = b.IdPersona
			inner join tbl_roles r on r.IdRol = b.IdRol
			where 			
			 
				r.Estado = 'A' and
		    b.IdUsuario = IdUsuario_;		  
					
		end if;
		
		
		/*para recuperar clave*/
		if opcion_ = 3  then
			if(select 1 from tbl_personas where LOWER(Correo) = rtrim(lower(Correo_))) = 1 then
					update tbl_usuarios set ClaveTemp = Clave_ , Estado = 'X'
					where IdPersona = ( select IdPersona from tbl_personas where lower(Correo) = rtrim(lower(Correo_)) );
					
					 select '0000' as CodigoError, 'Se generó clave temporal sastisfactoriamente revise su correo para usarla.' as MensajeError;
			else
				 select '0001' as CodigoError, 'El correo que ingresó no está registrado en el sistema, ' as MensajeError;
			end if;
				
		end if;
		
		
	/*para el servicio batch consultara las claves a generar*/
	if opcion_ = 4 then
						select 
								usr.IdUsuario, 
								usr.Usuario,	
								per.Nombres, 
								per.Apellidos,								
								per.Correo,
								per.TelefonoCelular,
								usr.ClaveTemp
			      from tbl_personas per inner join tbl_usuarios usr on per.IdPersona = usr.IdPersona
						where usr.Estado = 'X';
	end if;
	
	
	/*para marcar usuario al que ya se le envio la clave temporal*/
	if opcion_ = 5 then
		update tbl_usuarios set Estado = 'R' where IdUsuario = IdUsuario_ ;
		select '0000' as CodigoError, 'Marcado Exitosamente.' MensajeError ;	
	end if;
	
	
	/*para cambiar la clave nueva que es reseteada en el front*/
	if opcion_ = 6 then
		update tbl_usuarios set Estado = 'A' , Clave = Clave_ , ClaveTemp = null where IdUsuario = IdUsuario_;
	  select '0000' as CodigoError, 'Clave Actualizada Exitosamente.' MensajeError;
	end if;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_personas_crud
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_personas_crud`;
delimiter ;;
CREATE PROCEDURE `sp_personas_crud`(opcion_ int,
	IdPersona_ bigint,
	TipoIdentificacion_ varchar(3),
	Identificacion_ varchar(13),
	Nombres_ varchar(100),
	Apellidos_ varchar(100),
	FechaNacimiento_ date,
	TelefonoConvencional_ varchar(25),
	TelefonoCelular_ varchar(10),
	Correo_ varchar(150),
	Direccion_ varchar(500),
	PathImagen_ text,
	IdRol_ int,
	NombreUsuario_ varchar(50),
	Clave_ text,
	Usuario_ varchar(50),
	Sexo_ char(1))
begin
	
	 /* seccion para retornar algun error que se pueda generar  en la transaccion */
	 /*=======================================================================================*/
			 declare exit HANDLER for SQLEXCEPTION
			 begin
					get diagnostics CONDITION 1 @p1 = RETURNED_SQLSTATE,@p2 = MESSAGE_TEXT;				 
					select @p1 as CodigoError , @p2 as MensajeError;	
					
			 end;
	 /*=======================================================================================*/			
	 
	 
	 /*para consultar registros de personas y usuarios administrador*/
	 if opcion_ = 1 then
		  
			select 
					a.IdPersona,
					a.TipoIdentificacion,
					a.Identificacion,
					a.Sexo,
					a.Nombres,
					a.Apellidos,
					DATE_FORMAT(a.FechaNacimiento, "%Y-%m-%d") as FechaNacimiento,
					a.TelefonoConvencional,
					a.TelefonoCelular,
					a.Correo,
					a.Direccion,
					a.PathImagen,
					a.Estado as EstadoPersona,
					b.IdRol,
					r.Rol,
					b.IdUsuario,
					b.Usuario,
					b.Estado as EstadoUsuario
			from tbl_personas a inner join tbl_usuarios b on a.IdPersona = b.IdPersona
			inner join tbl_roles r on r.IdRol = b.IdRol
			where 
						
						a.Estado <> 'E' and
			      a.IdPersona = ifnull(IdPersona_,a.IdPersona) AND
						a.Identificacion like CONCAT('%',ifnull(Identificacion_,a.Identificacion),'%') and
						a.Nombres like CONCAT('%',ifnull(Nombres_,a.Nombres),'%')  AND
						a.Apellidos like CONCAT('%',ifnull(Apellidos_,a.Apellidos),'%');  		
	 
	 end if;
 
 
	 
	 /* agregar persona usuario */
	 if opcion_ = 5 then
			
			if(select 1 from tbl_personas where LOWER(Correo) =  lower(ltrim(rtrim(Correo_))) and Identificacion = LTRIM(RTRIM(Identificacion_)) and Estado <> 'E' limit 1 ) = 1 then
			
					select '0001' as CodigoError, 'Usuario ya se encuentra registrado!' as MensajeError;		
			
			else
			
					
					
							if (select 1 from tbl_usuarios where LOWER(Usuario) = LOWER(LTRIM(RTRIM(NombreUsuario_))) and Estado <> 'E' limit 1 ) = 1 then
							
									select '0001' as CodigoError, 'Usuario ya se encuentra registrado!!' as MensajeError;			
								
								else
									
									insert into tbl_personas(TipoIdentificacion,Identificacion,Nombres,Apellidos,FechaNacimiento,TelefonoConvencional,TelefonoCelular,Correo,Direccion,PathImagen,Estado,FechaCrea,UsuarioCrea,Sexo)
									values
									(
											TipoIdentificacion_,Identificacion_,Nombres_,Apellidos_,FechaNacimiento_,TelefonoConvencional_,TelefonoCelular_,Correo_,Direccion_,PathImagen_,'A',now(),Usuario_,Sexo_
									);
									
									insert into tbl_usuarios(IdPersona,IdRol,Usuario,ClaveTemp,Estado,UsuarioCrea,FechaCrea)
									values
									(
										 (select LAST_INSERT_ID()), IdRol_ ,  NombreUsuario_, Clave_, 'X', Usuario_, now()
									);
									
									select '0000' as CodigoError, 'Usuario creado correctamente' as MensajeError;
							
							end if;
					
					end if;
	 
	 end if;
	 	 
	 	 
	 /* actualizar persona usuario */
	 if opcion_ = 6 then
			
			if(select 1 from tbl_personas where (LOWER(Correo) =  lower(ltrim(rtrim(Correo_))) or Identificacion = LTRIM(RTRIM(Identificacion_)) )  and IdPersona <> IdPersona_ and Estado <> 'E' limit 1 ) = 1 then
			
					select '0001' as CodigoError, 'Usuario ya se encuentra registrado con esos datos.' as MensajeError;			
					
			
			
					
					else
					
							if (select 1 from tbl_usuarios where LOWER(Usuario) = LOWER(LTRIM(RTRIM(NombreUsuario_))) and IdPersona <> IdPersona_  and Estado <> 'E'  limit 1 ) = 1 then
							
									select '0001' as CodigoError, 'Usuario ya se encuentra registrado con esos datos!' as MensajeError;			
								
								else
									
									 update tbl_personas 
																			set Identificacion = IFNULL(Identificacion_,Identificacion) ,
																					TipoIdentificacion = ifnull(TipoIdentificacion_ ,TipoIdentificacion) ,
																					Direccion = ifnull(Direccion_,Direccion),
																					Correo = IFNULL(Correo_,Correo),
																					TelefonoConvencional = ifnull(TelefonoConvencional_,TelefonoConvencional),
																					TelefonoCelular = ifnull(TelefonoCelular_,TelefonoCelular),
																					FechaNacimiento = ifnull(FechaNacimiento_,FechaNacimiento),
																					PathImagen = ifnull(PathImagen_, PathImagen),
																					FechaActualiza = now(),
																					UsuarioActualiza = Usuario_,
																					Sexo = IFNULL(Sexo_,Sexo)
									where IdPersona = IdPersona_ ;
									
									
									update tbl_usuarios 
																			set Usuario = NombreUsuario_,
																					Clave = Ifnull(Clave_,Clave),
																					FechaActualiza = now(),
																					UsuarioActualiza = Usuario_
									where IdPersona = IdPersona_ ;
									
									 
									
									select '0000' as CodigoError, 'Usuario actualizado correctamente' as MensajeError;
							
							end if; 
					end if;
	 
	 end if;
	 
	 
	 /* para activar usuario */
	 if opcion_ = 7 then			
			
				update tbl_usuarios 
														set Estado = 'A',
																FechaActualiza = now(),
																UsuarioActualiza = Usuario_
				where IdPersona = IdPersona_;
				
				select '0000' as CodigoError, 'Usuario activado correctamente' as MensajeError;
	 
	 end if;
	 
	 
	 /* para inactivar usuario */
	 if opcion_ = 8 then			
			
				update tbl_usuarios 
														set Estado = 'I',
																FechaActualiza = now(),
																UsuarioActualiza = Usuario_
				where IdPersona = IdPersona_;
				
				select '0000' as CodigoError, 'Usuario inactivado correctamente' as MensajeError;
	 
	 end if;
	 	 
	  	
	 /* para eliminar usuario */
	 if opcion_ = 9 then			
	 
	     update tbl_personas 
														set Estado = 'E',
																FechaElimina = now(),
																UsuarioElimina = Usuario_
				where IdPersona = IdPersona_;
	 
			
				update tbl_usuarios 
														set Estado = 'E',
																FechaElimina = now(),
																UsuarioElimina = Usuario_
				where IdPersona = IdPersona_;
				
				select '0000' as CodigoError, 'Usuario eliminado correctamente' as MensajeError;
	 
	 end if;
	 
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
