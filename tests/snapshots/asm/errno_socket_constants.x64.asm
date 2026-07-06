
errno_socket_constants.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	popq	%rdx
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rdx
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	leaq	-0x40(%rbp), %rsi
               	movslq	%edx, %rdi
               	movslq	(%rsi,%rdi,4), %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
