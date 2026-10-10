
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	movl	%eax, 0x10(%rdi)
               	movl	$0x0, 0x14(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rax      # <addr>
               	movq	$0x64, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x7, (%rax)
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
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
               	jae	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movabsq	$0x7ffffffffffffffc, %rcx # imm = 0x7FFFFFFFFFFFFFFC
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x9, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
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
               	jae	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movabsq	$-0x7ffffffffffffffc, %rcx # imm = 0x8000000000000004
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
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
               	jae	<addr>
               	cmpl	$-0x16, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
