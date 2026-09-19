
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
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	movq	$0x64, (%rbx)
               	leaq	<rip>, %r13
               	movl	$0x7, (%r13)
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	callq	*%rax
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movq	$-0x16, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movabsq	$0x7ffffffffffffffc, %rax # imm = 0x7FFFFFFFFFFFFFFC
               	movq	%rax, (%rbx)
               	movl	$0x9, (%r13)
               	leaq	-0x18(%rbp), %rdi
               	movq	(%r12), %rax
               	callq	*%rax
               	leaq	-0x18(%rbp), %rcx
               	movq	0x8(%rcx), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	movq	$-0x16, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movabsq	$-0x7ffffffffffffffc, %rax # imm = 0x8000000000000004
               	movq	%rax, (%rbx)
               	movq	(%r12), %rax
               	movq	%rcx, %rdi
               	callq	*%rax
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movq	$-0x16, %rax
               	cmpl	$-0x16, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	0x8(%rax), %rcx
               	movl	0x10(%rax), %eax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	%rcx, %rax
               	jb	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	0x8(%rcx), %rdx
               	movl	0x10(%rcx), %eax
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	movl	0x10(%rax), %eax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	%rcx, %rax
               	jb	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
