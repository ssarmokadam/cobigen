package ${variables.rootPackage}.${variables.component}.dataaccess.api;

import ${variables.rootPackage}.${variables.component}.common.api.${variables.entityName};
import ${variables.rootPackage}.general.dataaccess.api.ApplicationPersistenceEntity;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.Transient;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;
import javax.validation.constraints.NotNull;

<#if model.description??>
/**
 * ${model.description}
 */
 <#else>
 /**
 * Data access object for ${variables.entityName} entities
 */
 </#if>
@Entity
@javax.persistence.Table(name = "${variables.entityName}")
public class ${variables.entityName?cap_first}Entity extends ApplicationPersistenceEntity implements ${variables.entityName} {

  private static final long serialVersionUID = 1L;

<#list model.properties as property>
	<#if property.name != "id">
		<#if property.description??>
	/**
	* ${property.description}
	*/
		</#if>
		<#if property.constraints.maximum??>
	@Max(${property.constraints.maximum})
		</#if>
		<#if property.constraints.minimum??>
	@Min(${property.constraints.minimum})
		</#if>
		<#if property.required>
	${property.required?c}
	@NotNull
		</#if>
		<#if property.constraints.maxLength?? && !property.constraints.minLength??>
	@Size(max = ${property.constraints.maxLength})
		<#elseif !property.constraints.maxLength?? && property.constraints.minLength??>
	@Size(min = ${property.constraints.minLength})
		<#elseif property.constraints.maxLength?? && property.constraints.minLength??>
	@Size(max = ${property.constraints.maxLength}, min = ${property.constraints.minLength})	
		</#if>
	private ${OpenApiUtil.toJavaType(property, false)} ${property.name};
	</#if>
</#list>

<#list model.properties as property>
	<#if property.name != "id">
	  <#if !property.isCollection>
	@Override
	  </#if>
	public void set${property.name?cap_first}(${OpenApiUtil.toJavaType(property, false)} ${property.name}) {
	  this.${property.name} = ${property.name};
	}
	
	  <#if !property.isCollection>
	@Override
	  </#if>
	public ${OpenApiUtil.toJavaType(property, false)} <#if property.type == "boolean">is<#else>get</#if>${property.name?cap_first}() {
	  return this.${property.name};
	} 
	</#if>
	
	<#if property.sameComponent>
  @Override
  @Transient
  public Long get${property.type}Id() {
    
    if (this.${property.type?uncap_first} == null) {
      return null;
    }
    return this.${property.type?uncap_first}.getId();
  }
  
  @Override
  public void set${property.type}Id(Long ${property.type?uncap_first}Id) {

    if (${property.type?uncap_first}Id == null) {
      this.${property.type?uncap_first} = null;
    } else {
      ${property.type}Entity ${property.type?uncap_first} = new ${property.type}Entity();
      ${property.type?uncap_first}.setId(${property.type?uncap_first}Id);
      this.${property.type?uncap_first} = ${property.type?uncap_first};
    }
  }
  </#if>
</#list>

<#-- <#list model.relationShips as rs>
  <#if rs.sameComponent>
  ${OaspUtil.getRelationShipAnnotation(rs, variables.entityName)}
  public <#if rs.type == "manytomany" || rs.type == "onetomany">List<${rs.entity}Entity><#else>${rs.entity}Entity</#if> get${rs.entity}<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if> () {
    return this.${rs.entity?uncap_first}<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if>;
  }
  
  public void set${rs.entity}<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if>(<#if rs.type == "manytomany" || rs.type == "onetomany">List<${rs.entity}Entity><#else>${rs.entity}Entity</#if> ${rs.entity?uncap_first}<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if>) {
    this.${rs.entity?uncap_first}<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if> =  ${rs.entity?uncap_first}<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if>;
  }
  
  <#else>
	<#if rs.type != "manytomany" && rs.type != "onetomany">
  @Override
	</#if>
  public <#if rs.type == "manytomany" || rs.type == "onetomany">List<Long><#else>Long</#if> get${rs.entity}Id<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if> () {
    return this.${rs.entity?uncap_first}Id<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if>;
  }
  
  <#if rs.type != "manytomany" && rs.type != "onetomany">
  @Override
	</#if>
  public void set${rs.entity}Id<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if>(<#if rs.type == "manytomany" || rs.type == "onetomany">List<Long><#else>Long</#if> ${rs.entity?uncap_first}Id<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if>) {
    this.${rs.entity?uncap_first}Id<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if> =  ${rs.entity?uncap_first}Id<#if rs.type == "manytomany" || rs.type == "onetomany">s</#if>;
  }
  </#if>
</#list> -->
}
