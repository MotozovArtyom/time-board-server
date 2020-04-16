package com.timeboard.server.domain.accounts;

import java.util.UUID;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "TaskAttachment")
@Table(name = "task_attachment", schema = "accounts")
public class TaskAttachment {

	@Id
	@Column(name = "id", unique = true, nullable = false)
	private UUID id;

	@Column(name = "attachment_name", nullable = false)
	private String attachmentName;

	@Column(name = "url", unique = true, nullable = false)
	private String url;

	@ManyToOne(targetEntity = Task.class,
			fetch = FetchType.LAZY,
			optional = false)
	@JoinColumn(name = "task", nullable = false, referencedColumnName = "id")
	private Task task;

	public TaskAttachment() {
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public String getAttachmentName() {
		return attachmentName;
	}

	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Task getTask() {
		return task;
	}

	public void setTask(Task task) {
		this.task = task;
	}
}