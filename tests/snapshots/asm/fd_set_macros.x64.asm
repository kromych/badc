
fd_set_macros.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x88, %rsp
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	movb	%dl, (%rsp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rsp,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	movzbq	(%rsp), %rax
               	orq	$0x1, %rax
               	orq	$0x80, %rax
               	movb	%al, (%rsp)
               	orb	$0x1, 0x1(%rsp)
               	orb	$0x10, 0xc(%rsp)
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x88, %rsp
               	retq
               	movzbq	(%rsp), %rax
               	testb	$0x2, %al
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x88, %rsp
               	retq
               	movzbq	0x6(%rsp), %rcx
               	testb	$0x4, %cl
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x88, %rsp
               	retq
               	cmpl	$0x81, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x88, %rsp
               	retq
               	movzbq	0x1(%rsp), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x88, %rsp
               	retq
               	movzbq	0xc(%rsp), %rdx
               	cmpl	$0x10, %edx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x88, %rsp
               	retq
               	andq	$-0x81, %rax
               	movb	%al, (%rsp)
               	testb	$-0x80, %al
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x88, %rsp
               	retq
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x16, %eax
               	addq	$0x88, %rsp
               	retq
               	testb	$0x1, %cl
               	jne	<addr>
               	movl	$0x17, %eax
               	addq	$0x88, %rsp
               	retq
               	orq	$0x1, %rax
               	movb	%al, (%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, (%rsp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	movzbq	(%rsp), %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x88, %rsp
               	retq
               	movzbq	0xc(%rsp), %rax
               	testb	$0x10, %al
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x88, %rsp
               	retq
