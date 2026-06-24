
unsigned_arith_high_half.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xff00ff00, %eax       # imm = 0xFF00FF00
               	xorq	$-0x1, %rax
               	movl	%eax, %eax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	shlq	$0x4, %rax
               	movl	%eax, %eax
               	xorq	$0x23456780, %rax       # imm = 0x23456780
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	subq	%rcx, %rax
               	movl	%eax, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
