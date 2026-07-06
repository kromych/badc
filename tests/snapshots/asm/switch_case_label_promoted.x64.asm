
switch_case_label_promoted.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$-0x100000000, %rax     # imm = 0xFFFFFFFF00000000
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jl	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	cmpq	%r11, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
