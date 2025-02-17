package com.example.slotbook.ui

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.example.slotbook.R
import com.example.slotbook.database.InterviewDatabase
import com.example.slotbook.helper.NotificationHelper
import com.example.slotbook.model.BookedSlot
import kotlinx.coroutines.launch

class BookSlotActivity : AppCompatActivity() {
    private lateinit var btnBookSlot: Button
    private lateinit var notificationHelper: NotificationHelper
    private lateinit var database: InterviewDatabase

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_book_slot)

        notificationHelper = NotificationHelper(this)
        database = InterviewDatabase.getDatabase(this)
        btnBookSlot = findViewById(R.id.btnBookSlot)

        val slotId = intent.getIntExtra("slotId", -1)
        val slotTime = intent.getStringExtra("slotTime") ?: "10.00am"
        val interviewerName = intent.getStringExtra("interviewerName") ?: "Interviewer"

        btnBookSlot.setOnClickListener {
            lifecycleScope.launch {
                val bookedSlot = BookedSlot(
                    slotId = slotId,
                    bookedBy = 123, // Assume user ID, replace with actual user ID
                    slotTime = slotTime,
                    interviewerName = interviewerName
                )

                database.bookedSlotDao().bookSlot(bookedSlot)

                runOnUiThread {
                    notificationHelper.sendEmailNotification(
                        "Slot Booked Successfully",
                        "Your interview slot with $interviewerName at $slotTime has been booked."
                    )
                    Toast.makeText(this@BookSlotActivity, "Slot Booked!", Toast.LENGTH_SHORT).show()

                    // Navigate to TechTrackActivity
                    val intent = Intent(this@BookSlotActivity, TechTrackActivity::class.java)
                    startActivity(intent)
                    finish()
                }
            }
        }
    }
}


