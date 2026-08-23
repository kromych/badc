
arrays_basic.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rsi
               	leaq	(%rsi), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x2, %eax
               	movl	%eax, 0x4(%rsi)
               	movl	$0x3, %eax
               	movl	%eax, 0x8(%rsi)
               	movl	$0x4, %eax
               	movl	%eax, 0xc(%rsi)
               	movl	$0x5, %eax
               	movl	%eax, 0x10(%rsi)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	(%rsi,%rdx,4), %rax
               	addq	%rax, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	<rip>, %rax
               	movl	$0x14, %edx
               	movl	%edx, 0x8(%rax)
               	leaq	<rip>, %rax
               	movl	$0x1e, %edx
               	movl	%edx, 0xc(%rax)
               	leaq	<rip>, %rax
               	movl	$0x28, %edx
               	movl	%edx, 0x10(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0x8(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0xc(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0x10(%rax), %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x68, %edx
               	movb	%dl, (%rax)
               	movl	$0x69, %esi
               	movb	%sil, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	movsbq	%dl, %rax
               	cmpq	$0x68, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x69, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
