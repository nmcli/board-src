package com.example.board.controller;

import com.example.board.entity.Board;
import com.example.board.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    private final BoardService boardService;

    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @GetMapping
    public String list(Model model) {
        List<Board> boards = boardService.findAll();
        model.addAttribute("boards", boards);
        return "board/list";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Board board = boardService.findById(id);
        model.addAttribute("board", board);
        return "board/detail";
    }
}
