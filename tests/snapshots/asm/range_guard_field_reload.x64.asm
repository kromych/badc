
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
               	movl	$0x1, %eax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	%eax, 0x10(%rdi)
               	xorq	%rax, %rax
               	movl	%eax, 0x14(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rbx
               	movl	$0x64, %eax
               	movq	%rax, (%rbx)
               	leaq	<rip>, %r13
               	movl	$0x7, %eax
               	movl	%eax, (%r13)
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	callq	*%rax
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movabsq	$-0x16, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$0x7ffffffffffffffc, %rax # imm = 0x7FFFFFFFFFFFFFFC
               	movq	%rax, (%rbx)
               	movl	$0x9, %eax
               	movl	%eax, (%r13)
               	leaq	-0x18(%rbp), %rdi
               	movq	(%r12), %rax
               	callq	*%rax
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movabsq	$-0x16, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x7ffffffffffffffc, %rcx # imm = 0x8000000000000004
               	movq	%rcx, (%rbx)
               	movq	(%r12), %rcx
               	movq	%rax, %rdi
               	callq	*%rcx
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movabsq	$-0x16, %rax
               	cmpq	$-0x16, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x8(%rax), %rcx
               	movl	0x10(%rax), %eax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%ecx, %eax
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	movl	0x10(%rax), %ecx
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	cmpq	%rdx, %rcx
               	jae	<addr>
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movl	%edx, %ecx
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	movl	0x10(%rax), %eax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%ecx, %eax
               	jmp	<addr>
