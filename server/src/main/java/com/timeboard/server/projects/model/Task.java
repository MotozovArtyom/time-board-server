package com.timeboard.server.projects.model;

import java.time.ZonedDateTime;
import java.util.UUID;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "ProjectTask")
@Table(name = "task", schema = "public")
public class Task {

	@Id
	@Column(name = "id", unique = true, nullable = false)
	@GeneratedValue
	private UUID id;

	@Column(name = "number", unique = true, nullable = false)
	private Integer number;

	@Column(name = "full_code", unique = true, nullable = false)
	private String fullCode;

	@Column(name = "creation_date", nullable = false)
	private ZonedDateTime creationDate;

	@Column(name = "done_date")
	private ZonedDateTime doneDate;

	@Column(name = "last_modified", nullable = false)
	private ZonedDateTime lastModified;

	@Column(name = "description", nullable = false)
	private String description;

	@Column(name = "name", nullable = false)
	private String name;

	@ManyToOne(targetEntity = ProjectDashboard.class,
			fetch = FetchType.LAZY,
			optional = false)
	@JoinColumn(name = "project", nullable = false)
	private ProjectDashboard project;

	@ManyToOne(targetEntity = Step.class,
			fetch = FetchType.LAZY,
			optional = false)
	@JoinColumn(name = "step", nullable = false)
	private Step step;

	@ManyToOne(targetEntity = GroupTask.class,
			fetch = FetchType.LAZY,
			optional = false)
	@JoinColumn(name = "group_task")
	private GroupTask groupTask;

	@ManyToOne(targetEntity = ProjectUser.class,
			fetch = FetchType.LAZY,
			optional = false)
	@JoinColumn(name = "executor")
	private ProjectUser executor;

	@ManyToOne(targetEntity = ProjectUser.class,
			fetch = FetchType.LAZY,
			optional = false)
	@JoinColumn(name = "reporter", nullable = false)
	private ProjectUser reporter;

	@Column(name = "version", nullable = false)
	private Long version;

	public Task() {
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getFullCode() {
		return fullCode;
	}

	public void setFullCode(String fullCode) {
		this.fullCode = fullCode;
	}

	public ZonedDateTime getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(ZonedDateTime creationDate) {
		this.creationDate = creationDate;
	}

	public ZonedDateTime getDoneDate() {
		return doneDate;
	}

	public void setDoneDate(ZonedDateTime doneDate) {
		this.doneDate = doneDate;
	}

	public ZonedDateTime getLastModified() {
		return lastModified;
	}

	public void setLastModified(ZonedDateTime lastModified) {
		this.lastModified = lastModified;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ProjectDashboard getProject() {
		return project;
	}

	public void setProject(ProjectDashboard project) {
		this.project = project;
	}

	public Step getStep() {
		return step;
	}

	public void setStep(Step step) {
		this.step = step;
	}

	public GroupTask getGroupTask() {
		return groupTask;
	}

	public void setGroupTask(GroupTask groupTask) {
		this.groupTask = groupTask;
	}

	public ProjectUser getExecutor() {
		return executor;
	}

	public void setExecutor(ProjectUser executor) {
		this.executor = executor;
	}

	public ProjectUser getReporter() {
		return reporter;
	}

	public void setReporter(ProjectUser reporter) {
		this.reporter = reporter;
	}

	public Long getVersion() {
		return version;
	}

	public void setVersion(Long version) {
		this.version = version;
	}
}
