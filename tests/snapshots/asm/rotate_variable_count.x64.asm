
rotate_variable_count.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rotr_var>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	rorq	%cl, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<ref_ror>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movslq	%esi, %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	$0x40, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movl	$0x1, %edx
               	movslq	%ecx, %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	%ecx, %rdx
               	subq	%rsi, %rdx
               	movslq	%edx, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x1, %r8d
               	movslq	%edx, %rdx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rax
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	popq	%r11
               	xorq	%rbx, %rbx
               	movl	%ebx, %eax
               	movl	$0x30, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	jmp	<addr>
               	movl	%ebx, %eax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	movl	$0x1, %r12d
               	jmp	<addr>
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	movq	%rdi, %rbx
               	rorq	$0x7, %rbx
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	jmp	<addr>
               	movslq	%r12d, %rax
               	cmpq	$0x40, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r12d, %rax
               	movq	%rax, %r12
               	incq	%r12
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movl	%ebx, %ecx
               	movq	(%rax,%rcx,8), %rdi
               	movslq	%r12d, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x30(%rbp), %rax
               	movl	%ebx, %ecx
               	movq	(%rax,%rcx,8), %rdi
               	movslq	%r12d, %rsi
               	callq	<addr>
               	cmpq	%rax, %r14
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
