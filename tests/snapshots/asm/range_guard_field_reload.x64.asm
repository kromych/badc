
range_guard_field_reload.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<fill>:
               	movq	$0x1, (%rdi)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rdi)
               	movl	<rip>, %eax # <addr>
               	movq	%rax, 0x10(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	$0x64, <rip> # <addr>
               	movl	$0x7, <rip> # <addr>
               	leaq	-0x18(%rbp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	leaq	-0x18(%rbp), %rdx
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rsi
               	movl	-0x8(%rbp), %eax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	cmovaeq	%rcx, %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movabsq	$0x7ffffffffffffffc, %rax # imm = 0x7FFFFFFFFFFFFFFC
               	movq	%rax, <rip> # <addr>
               	movl	$0x9, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rdx, %rdi
               	callq	*%rax
               	leaq	-0x18(%rbp), %rdx
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rsi
               	movl	-0x8(%rbp), %eax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	cmovaeq	%rcx, %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movabsq	$-0x7ffffffffffffffc, %rax # imm = 0x8000000000000004
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rdx, %rdi
               	callq	*%rax
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rdx
               	movl	-0x8(%rbp), %eax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	cmovaeq	%rcx, %rax
               	cmpl	$-0x16, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
