@ECHO OFF

REM gracethdcheck_pg_create_tables.bat
REM Owner : GraceTHD-Community - http://gracethd-community.github.io/
REM Author : stephane dot byache at aleno dot eu
REM Rev. date : 25/06/2018


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

REM ATTENTION Pointer sur un dossier accessible au user. 


:LAUNCH
REM Lecture du fichier de configuration. 
CALL:CONF

REM Decommenter quand ca coince. 
REM CALL :DEBUG

ECHO GRACETHD-Data - PG - Debut export CSV depuis la base PostGIS %PGHOSTNAME%:%PGDB% vers %PGSHPOUTPATH%. 
CALL:EXPORTREL
CALL:EXPORTDATA
CALL:END
%GLPAUSE%
GOTO:EOF

:CONF
CALL config.bat
SET PGSCHEMADATA=%PGSCHEMA%data

REM Pour forcer les pauses sans modifier le config.bat
REM SET GLPAUSE=PAUSE

GOTO:EOF

:DEBUG
REM Pour forcer les pauses sans modifier le config.bat
SET GLPAUSE=PAUSE
CALL config_test.bat
GOTO:EOF

:OK
REM Pour placer les commandes deja passees quand ca coince
GOTO:EOF

:EXPORTREL

REM pgsql2shp -f "D:\postgres_files\shpcsv-out\t_adresse" -h localhost -p 5433 -u postgres -P MYPASSWORD gracethd-v2-beta1b gracethd.t_zcoax

SET PGTBL=t_dt_organisme_rel
SET PGCSV=%PGSHPOUTPATH%\%PGTBL%.csv
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "\COPY %PGSCHEMADATA%.%PGTBL% TO '%PGCSV%' %PGCSVCONF%;" -d %PGDB% %PGUSER%

SET PGTBL=t_dt_reference_rel
SET PGCSV=%PGSHPOUTPATH%\%PGTBL%.csv
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "\COPY %PGSCHEMADATA%.%PGTBL% TO '%PGCSV%' %PGCSVCONF%;" -d %PGDB% %PGUSER%

%GLPAUSE%
PAUSE

GOTO:EOF

:EXPORTDATA

REM pgsql2shp -f "D:\postgres_files\shpcsv-out\t_adresse" -h localhost -p 5433 -u postgres -P MYPASSWORD gracethd-v2-beta1b gracethd.t_zcoax

SET PGTBL=t_dt_organisme
SET PGCSV=%PGSHPOUTPATH%\%PGTBL%.csv
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "\COPY %PGSCHEMADATA%.%PGTBL% TO '%PGCSV%' %PGCSVCONF%;" -d %PGDB% %PGUSER%

SET PGTBL=t_dt_reference
SET PGCSV=%PGSHPOUTPATH%\%PGTBL%.csv
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "\COPY %PGSCHEMADATA%.%PGTBL% TO '%PGCSV%' %PGCSVCONF%;" -d %PGDB% %PGUSER%

SET PGTBL=t_dt_tgkey
SET PGCSV=%PGSHPOUTPATH%\%PGTBL%.csv
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "\COPY %PGSCHEMADATA%.%PGTBL% TO '%PGCSV%' %PGCSVCONF%;" -d %PGDB% %PGUSER%

SET PGTBL=t_dt_tgkey_user
SET PGCSV=%PGSHPOUTPATH%\%PGTBL%.csv
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "\COPY %PGSCHEMADATA%.%PGTBL% TO '%PGCSV%' %PGCSVCONF%;" -d %PGDB% %PGUSER%

SET PGTBL=t_dt_tag
SET PGCSV=%PGSHPOUTPATH%\%PGTBL%.csv
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "\COPY %PGSCHEMADATA%.%PGTBL% TO '%PGCSV%' %PGCSVCONF%;" -d %PGDB% %PGUSER%

SET PGTBL=t_dt_tag_user
SET PGCSV=%PGSHPOUTPATH%\%PGTBL%.csv
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "\COPY %PGSCHEMADATA%.%PGTBL% TO '%PGCSV%' %PGCSVCONF%;" -d %PGDB% %PGUSER%


%GLPAUSE%
PAUSE

GOTO:EOF


:NOK
REM Pour placer des commandes en attente, quand ca coince. 


GOTO:EOF


:END
ECHO GRACETHD - PG - %PGSHPOUTPATH% : EXPORT TERMINE

%GLPAUSE%
