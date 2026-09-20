
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	%eax, 0x10(%rdi)
               	movl	$0x0, 0x14(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rax
               	movq	$0x64, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x7, (%rax)
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rsi
               	movl	0x10(%rax), %ecx
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rsi, %rdx
               	cmpq	%rdx, %rcx
               	jae	<addr>
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movabsq	$0x7ffffffffffffffc, %rdx # imm = 0x7FFFFFFFFFFFFFFC
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x9, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %rdi
               	callq	*%rcx
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rsi
               	movl	0x10(%rax), %ecx
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rsi, %rdx
               	cmpq	%rdx, %rcx
               	jae	<addr>
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movabsq	$-0x7ffffffffffffffc, %rdx # imm = 0x8000000000000004
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %rdi
               	callq	*%rcx
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rdx
               	movl	0x10(%rax), %eax
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
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
