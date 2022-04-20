mod_authz_umichlib.la: mod_authz_umichlib.slo
	$(SH_LINK) -rpath $(libexecdir) -module -avoid-version  mod_authz_umichlib.lo
DISTCLEAN_TARGETS = modules.mk
shared =  mod_authz_umichlib.la
