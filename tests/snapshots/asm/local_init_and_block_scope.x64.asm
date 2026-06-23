
local_init_and_block_scope.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_three>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rax, %rax
               	movl	$0x41, %ecx
               	leaq	<rip>, %rdx
               	movl	$0x1, %esi
               	movl	%esi, -0x20(%rbp)
               	movl	$0x3, %esi
               	movl	$0x2, %edi
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x41, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movsbq	(%rdx), %rax
               	cmpq	$0x68, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x1(%rdx), %rax
               	cmpq	$0x69, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x20(%rbp), %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x20(%rbp), %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rcx
               	cmpq	$0x6, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rcx
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %ecx
               	movl	$0x14, %edx
               	movl	$0x1e, %esi
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %ecx
               	cmpq	$0x63, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x60(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
