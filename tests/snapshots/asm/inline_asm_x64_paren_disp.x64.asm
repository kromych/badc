
inline_asm_x64_paren_disp.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax         # <addr>
               	jmp	<addr>
               	orl	(%rax), %eax
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	addb	%cl, -0x77(%rax)
               	clc
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	0x4(%rax), %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax         # <addr>
               	jmp	<addr>
               	andl	%eax, (%rax)
               	addb	%al, (%rax)
               	subb	$0x0, %al
               	addb	%al, (%rax)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x21, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
               	<unknown>
               	addb	%al, (%rax)
               	addb	%al, (%rdx)
               	addb	%al, (%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x37, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	0x4(%rax), %rax
               	cmpl	$0x42, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rbx
               	movl	0x4(%rbx), %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
