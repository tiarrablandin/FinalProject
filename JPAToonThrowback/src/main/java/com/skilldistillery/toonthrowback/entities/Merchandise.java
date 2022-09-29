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
public class Merchandise {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String image;
	
	private String url;
	
	private boolean active;
	
	private String description;
	
	@CreationTimestamp
	@Column(name="created_date")
	private LocalDateTime createdDate;
	
	@UpdateTimestamp
	@Column(name="update_date")
	private LocalDateTime updatedDate;
	
	@JsonIgnoreProperties({"merch"})
	@ManyToOne
	@JoinColumn(name="cartoon_id")
	private Cartoon cartoon;
	
	@JsonIgnoreProperties({"merch"})
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
/////////////////////////////////////////////////////////////////////////////////	

	public Merchandise() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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
		return "Merchandise [id=" + id + ", image=" + image + ", url=" + url + ", active=" + active + ", createdDate="
				+ createdDate + ", updatedDate=" + updatedDate + ", cartoon=" + cartoon + ", user=" + user + "]";
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
		Merchandise other = (Merchandise) obj;
		return id == other.id;
	}

}
