package com.skilldistillery.toonthrowback.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;



@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String image;
	
	private String username;
	
	private String password;
	
	private String email;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	private String bio;
	
	private boolean active;
	
	private String role;
	
	@CreationTimestamp
	@Column(name="created_date")
	private LocalDateTime createdDate;
	
	@UpdateTimestamp
	@Column(name="updated_date")
	private LocalDateTime updatedDate;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Cartoon> cartoon;
	
	@JsonIgnore
	@ManyToMany(mappedBy="userFavs")
	private List<Cartoon> favCartoons;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Media> media;
	
	@JsonIgnoreProperties({"user"})
	@OneToMany(mappedBy="user")
	private List<Comment> comment;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Fact> facts;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Merchandise> merch;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Trivia> trivia;
	
	public void addCartoon(Cartoon cartoon) {
		if (favCartoons == null) favCartoons = new ArrayList<>();
		
		if(!favCartoons.contains(cartoon)) {
			favCartoons.add(cartoon);
			cartoon.addFavorite(this);
		}
	}

	public void removeCartoon(Cartoon cartoon) {
		if(favCartoons != null && favCartoons.contains(cartoon)) {
			favCartoons.remove(cartoon);
			cartoon.removeFavorite(this);
		}
	}
	
/////////////////////////////////////////////////////////////////////////////////	

	public User() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getImage() {
		return image;
	}

	public void setImg(String image) {
		this.image = image;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
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

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public boolean getActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<Cartoon> getCartoon() {
		return cartoon;
	}

	public void setCartoon(List<Cartoon> cartoon) {
		this.cartoon = cartoon;
	}

	public List<Cartoon> getFavCartoons() {
		return favCartoons;
	}

	public void setFavCartoons(List<Cartoon> favCartoons) {
		this.favCartoons = favCartoons;
	}

	public List<Media> getMedia() {
		return media;
	}

	public void setMedia(List<Media> media) {
		this.media = media;
	}

	public List<Comment> getComment() {
		return comment;
	}

	public void setComment(List<Comment> comment) {
		this.comment = comment;
	}

	public List<Fact> getFacts() {
		return facts;
	}

	public void setFacts(List<Fact> facts) {
		this.facts = facts;
	}

	public List<Merchandise> getMerch() {
		return merch;
	}

	public void setMerch(List<Merchandise> merch) {
		this.merch = merch;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public List<Trivia> getTrivia() {
		return trivia;
	}

	public void setTrivia(List<Trivia> trivia) {
		this.trivia = trivia;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", img=" + image + ", username=" + username + ", password=" + password + ", email="
				+ email + ", firstName=" + firstName + ", lastName=" + lastName + ", bio=" + bio + ", active=" + active
				+ ", role=" + role + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + "]";
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
		User other = (User) obj;
		return id == other.id;
	}

}
