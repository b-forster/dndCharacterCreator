$(document).ready(function() {
  upVoteListener();
  downVoteListener();
  deleteCharListener();
  updatePhotoListener();
  showBonusListener();
  rollDieListener();
});

var upVoteListener = function(){
  $(".upvote-form").on("submit", function(event){
    event.preventDefault();

    var $form = $(this);

    var $request = $.ajax({
      type: "PUT",
      url: $form.attr("action"),
      data: $form.serialize()
    })

    $request.done(function(response){
      $form.closest("tr").find(".val_to_change").text(response)
    });
  })
}

var downVoteListener = function(){
  $(".downvote-form").on("submit", function(event){
    event.preventDefault();

    var $form = $(this);

    var $request = $.ajax({
      type: "PUT",
      url: $form.attr("action"),
      data: $form.serialize()
    })

    $request.done(function(response){
      $form.closest("tr").find(".val_to_change").text(response)
    });
  })
}

var deleteCharListener = function(){
  $("#delete-char-form").on("submit", function(event){
    event.preventDefault();

    var confirmDelete = confirm("Are you sure you want to delete this character?");

    if (confirmDelete === true){
      $form = $(this)
      var $request = $.ajax({
        type: "DELETE",
        url: $form.attr("action"),
      })

      $request.done(function(response){
        var url = "/users/" + response;
        top.location.href = url;
      })
    }
  })
}

var updatePhotoListener = function(){
  $("#new-char-class").on("change", function(){
    var charClass = $(this).val();
    var charImgObj = {
      'Barbarian' : "<img src='/images/Barb.jpg'>",
      'Bard' : "<img src='/images/Bard.jpg'>",
      'Cleric' : "<img src='/images/cleric.jpg'>",
      'Druid' : "<img src='/images/druid.jpg'>",
      'Fighter' : "<img src='/images/fighter.jpg'>",
      'Monk' : "<img src='/images/Monk.jpg'>",
      'Paladin' : "<img src='/images/Paladin.jpg'>",
      'Ranger' : "<img src='/images/Ranger.jpg'>",
      'Rogue' : "<img src='/images/Rogue.jpg'>",
      'Sorcerer' : "<img src='/images/sorcerer.jpg'>",
      'Warlock' : "<img src='/images/Warlock.jpg'>",
      'Wizard' : "<img src='/images/Wizard.jpg'>"
    }
    $(".char-img-div").find("img").replaceWith(charImgObj[charClass]);

  })
}

var showBonusListener = function(){
  $("#new-char-race").on("change", function(){
    var charRace = $(this).val();

    var $request = $.ajax({
      type: "GET",
      url: window.location.pathname,
      data: { "race": charRace }
    })

    $request.done(function(response){
      $(".stat-bonus").text("   ")

      var bonusesObj = JSON.parse(response);
      for (var bonusAttr in bonusesObj) {
        var bonusVal = bonusesObj[bonusAttr];
        $("#" + bonusAttr).append(" + <span class='bonus-val'>" + bonusVal + "</span>")
      }
    })
  });
}

var statRoll = function(){
  var die = [1,2,3,4,5,6];
    var rolls = [];
      for (var i = 0; i < 4; i++){
        var oneRoll = die[Math.floor(Math.random() * die.length)];
        rolls.push(oneRoll);
      }
    rolls.sort().reverse()
    var totalRoll = rolls[0] + rolls[1] + rolls[3]
    return totalRoll
}

var rollDieListener = function(){
  $('.die-img').on('click', function(){
    var thisDie = $(this);
    var statVal = thisDie.closest('td').find('.new-char-stat')

    statVal.val(statRoll);
  });
}



