package com.skilldistillery.toonthrowback.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;



@Entity
public class Trivia {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String question;
	
	private String answer;
	
	private boolean active;
	
	@CreationTimestamp
	@Column(name="created_date")
	private LocalDateTime createdDate;
	
	@UpdateTimestamp
	@Column(name="updated_date")
	private LocalDateTime updatedDate;
	
	@JsonIgnoreProperties({"trivias"})
	@ManyToOne
	@JoinColumn(name="cartoon_id")
	private Cartoon cartoon;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
/////////////////////////////////////////////////////////////////////////////////	

	public Trivia() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(LocalDateTime updatedDate) {
		this.updatedDate = updatedDate;
	}

	public Cartoon getCartoon() {
		return cartoon;
	}

	public void setCartoon(Cartoon cartoon) {
		this.cartoon = cartoon;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Trivia [id=" + id + ", question=" + question + ", answer=" + answer + ", active=" + active
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", cartoon=" + cartoon + ", user="
				+ user + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Trivia other = (Trivia) obj;
		return id == other.id;
	}

}
