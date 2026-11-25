
range_guard_field_reload.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movq	$0x64, <rip> # <addr>
               	movl	$0x7, <rip> # <addr>
               	leaq	0x8(%rsp), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	leaq	0x8(%rsp), %rsi
               	movq	0x10(%rsp), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x18(%rsp), %edx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rcx, %rax
               	cmpq	%rax, %rdx
               	cmovbq	%rdx, %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movabsq	$0x7ffffffffffffffc, %rax # imm = 0x7FFFFFFFFFFFFFFC
               	movq	%rax, <rip> # <addr>
               	movl	$0x9, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rsi, %rdi
               	callq	*%rax
               	leaq	0x8(%rsp), %rsi
               	movq	0x10(%rsp), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x18(%rsp), %edx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rcx, %rax
               	cmpq	%rax, %rdx
               	cmovbq	%rdx, %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movabsq	$-0x7ffffffffffffffc, %rax # imm = 0x8000000000000004
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rsi, %rdi
               	callq	*%rax
               	movq	0x10(%rsp), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jb	<addr>
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x18(%rsp), %edx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rcx, %rax
               	cmpq	%rax, %rdx
               	cmovbq	%rdx, %rax
               	cmpl	$-0x16, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
