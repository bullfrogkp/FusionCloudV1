<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="adminUserId" column="admin_user_id" fieldtype="id" generator="native"> 
    <cfproperty name="username" column="username" ormtype="string"> 
	<cfproperty name="password" column="password" ormtype="string"> 
	<cfproperty name="email" column="email" ormtype="string"> 
	<cfproperty name="phone" column="phone" ormtype="string"> 
	<cfproperty name="avatarName" column="avatar_name" ormtype="string"> 
	<cfproperty name="isAdministrator" column="is_administrator" ormtype="boolean"> 
	<cfproperty name="lastLoginDatetime" column="last_login_datetime" ormtype="timestamp"> 
</cfcomponent>