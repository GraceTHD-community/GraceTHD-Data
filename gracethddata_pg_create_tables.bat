@ECHO OFF

REM gracethd_pg_create_tables.bat
REM Owner : GraceTHD-Community - http://gracethd-community.github.io/
REM Author : stephane dot byache at aleno dot eu
REM Rev. date : 16/11/2017


    REM This file is part of GraceTHD.

    REM GraceTHD is free software: you can redistribute it and/or modify
    REM it under the terms of the GNU General Public License as published by
    REM the Free Software Foundation, either version 3 of the License, or
    REM (at your option) any later version.

    REM GraceTHD is distributed in the hope that it will be useful,
    REM but WITHOUT ANY WARRANTY; without even the implied warranty of
    REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    REM GNU General Public License for more details.

    REM You should have received a copy of the GNU General Public License
    REM along with GraceTHD.  If not, see <http://www.gnu.org/licenses/>.

	
REM Appel de la config
CALL :CONF

REM Decommenter quand ca coince. 
CALL:DEBUG

CALL :TABLES_GRACETHDDATA
CALL :INSERT_GRACETHDDATA
CALL :GRANT_GRACETHDDATA
REM Appel de la sous-routine END pour terminer l'execution ici. 
CALL :END

:CONF
CALL config.bat
GOTO:EOF

:DEBUG
REM Pour forcer les pauses sans modifier le config.bat
SET GLPAUSE=PAUSE
CALL config_test.bat
GOTO:EOF

:TABLES_GRACETHDDATA

SET FSQL=gracethddata_30_tables.sql
ECHO GraceTHD - Postgis - %FSQL%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\%FSQL%" -d %PGDB% -U %PGUSER%
%GLPAUSE%

GOTO:EOF

:INSERT_GRACETHDDATA

SET FSQL=gracethddata_31_insert.sql
ECHO GraceTHD - Postgis - %FSQL%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\%FSQL%" -d %PGDB% -U %PGUSER%

GOTO:EOF

:GRANT_GRACETHDDATA

SET FSQL=gracethddata_99_grant.sql
ECHO GraceTHD - Postgis - %FSQL%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\%FSQL%" -d %PGDB% -U %PGUSER%

GOTO:EOF

:END
ECHO GraceTHD-Check - Postgis - Fin de creation des tables GraceTHD-MCD. 

%GLPAUSE%
REM TODO: trouver une alernative au EXIT qui arrête tout. 
EXIT /B

REM GOTO:EOF