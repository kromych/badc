
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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	movl	$0x64, %eax
               	movq	%rax, (%rbx)
               	leaq	<rip>, %r12
               	movl	$0x7, %eax
               	movl	%eax, (%r12)
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	-0x18(%rbp), %rdi
               	movq	0x8(%rdi), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	movabsq	$-0x16, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$0x7ffffffffffffffc, %rax # imm = 0x7FFFFFFFFFFFFFFC
               	movq	%rax, (%rbx)
               	movl	$0x9, %eax
               	movl	%eax, (%r12)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	-0x18(%rbp), %rdi
               	movq	0x8(%rdi), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	movabsq	$-0x16, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x7ffffffffffffffc, %rax # imm = 0x8000000000000004
               	movq	%rax, (%rbx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
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
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	0x8(%rax), %rdx
               	movl	0x10(%rax), %ecx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%ecx, %eax
               	cmpq	%rdx, %rax
               	jae	<addr>
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%edx, %eax
               	jmp	<addr>
               	movq	0x8(%rdi), %rax
               	movl	0x10(%rdi), %ecx
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rax, %rdx
               	movl	%ecx, %eax
               	cmpq	%rdx, %rax
               	jae	<addr>
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%edx, %eax
               	jmp	<addr>
               	movq	0x8(%rdi), %rax
               	movl	0x10(%rdi), %ecx
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rax, %rdx
               	movl	%ecx, %eax
               	cmpq	%rdx, %rax
               	jae	<addr>
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%edx, %eax
               	jmp	<addr>
