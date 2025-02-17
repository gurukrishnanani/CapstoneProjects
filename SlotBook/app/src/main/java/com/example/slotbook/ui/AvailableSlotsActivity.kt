package com.example.slotbook.ui

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.slotbook.R
import com.example.slotbook.adapter.AvailableSlotsAdapter
import com.example.slotbook.database.InterviewDatabase
import com.example.slotbook.model.Slot
import kotlinx.coroutines.launch

class AvailableSlotsActivity : AppCompatActivity() {
    private lateinit var recyclerView: RecyclerView
    private lateinit var adapter: AvailableSlotsAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_available_slots)

        val trackId = intent.getIntExtra("trackId", -1)

        recyclerView = findViewById(R.id.recyclerViewSlots)
        recyclerView.layoutManager = LinearLayoutManager(this)

        // Fetching slots inside coroutine
        lifecycleScope.launch {
            val slots = InterviewDatabase.getDatabase(this@AvailableSlotsActivity).slotDao().getHardcodedSlots(trackId)
            adapter = AvailableSlotsAdapter(slots) { slot ->
                val intent = Intent(this@AvailableSlotsActivity, BookSlotActivity::class.java)
                intent.putExtra("slotId", slot.id)
                startActivity(intent)
            }
            recyclerView.adapter = adapter
        }
    }
}