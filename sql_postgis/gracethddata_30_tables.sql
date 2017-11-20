/* gracethddata_30_tables.sql */
/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 16/11/2017 */

/* ********************************************************************
    This file is part of GraceTHD.

    GraceTHD is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GraceTHD is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GraceTHD.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************** */

/*PostGIS*/

SET search_path TO gracethddata, gracethd, public;

DROP TABLE IF EXISTS t_reference_rel CASCADE;
DROP TABLE IF EXISTS t_organisme_rel CASCADE;
DROP TABLE IF EXISTS t_organisme_data CASCADE;
DROP TABLE IF EXISTS t_reference_data CASCADE;


CREATE TABLE t_organisme_data(	or_code VARCHAR (20) NOT NULL  ,
	or_siren VARCHAR(9)   ,
	or_nom VARCHAR(254) NOT NULL  ,
	or_type VARCHAR(254)   ,
	or_activ VARCHAR(254)   ,
	or_l331 VARCHAR(254)   ,
	or_siret VARCHAR(14)   ,
	or_nometab VARCHAR(254)   ,
	or_ad_code VARCHAR(254), --   REFERENCES t_adresse(ad_code),
	or_nomvoie VARCHAR (254)   ,
	or_numero INTEGER   ,
	or_rep VARCHAR (20)   ,
	or_local VARCHAR(254)   ,
	or_postal VARCHAR(20)   ,
	or_commune VARCHAR (254)   ,
	or_telfixe VARCHAR(20)   ,
	or_mail VARCHAR(254)   ,
	or_comment VARCHAR(254)   ,
	or_creadat TIMESTAMP   ,
	or_majdate TIMESTAMP   ,
	or_majsrc VARCHAR(254)   ,
	or_abddate DATE   ,
	or_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_organisme_data_pk" PRIMARY KEY (or_code));	

CREATE TABLE t_reference_data(	rf_code VARCHAR(254) NOT NULL  ,
	rf_type VARCHAR(2)   REFERENCES l_reference_type (code),
	rf_fabric VARCHAR(20), --  REFERENCES t_organisme (or_code),
	rf_design VARCHAR(254)   ,
	rf_etat VARCHAR(1)   REFERENCES l_reference_etat (code),
	rf_comment VARCHAR(254)   ,
	rf_creadat TIMESTAMP   ,
	rf_majdate TIMESTAMP   ,
	rf_majsrc VARCHAR(254)   ,
	rf_abddate DATE   ,
	rf_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_reference_data_pk" PRIMARY KEY (rf_code));	

CREATE TABLE t_organisme_rel(
	oo_codedat VARCHAR(254) REFERENCES t_organisme_data(or_code),
	oo_or_code VARCHAR(254) REFERENCES t_organisme(or_code),
CONSTRAINT "t_organisme_rel_pk" PRIMARY KEY (oo_codedat, oo_or_code)
);

CREATE TABLE t_reference_rel(
	rr_codedat VARCHAR(254) REFERENCES t_reference_data(rf_code),
	rr_rf_code VARCHAR(254) REFERENCES t_reference(rf_code),
CONSTRAINT "t_reference_rel_pk" PRIMARY KEY (rr_codedat, rr_rf_code)
);
