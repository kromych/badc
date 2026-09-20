
flex_array_member_static_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0xc(%rcx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rcx
               	movsbq	(%rcx), %rdx
               	cmpl	$-0x1, %edx
               	je	<addr>
               	addq	$0xa, %rax
               	retq
               	movl	$0x1, %eax
               	movsbq	0x1(%rcx), %rdx
               	cmpl	$-0x1, %edx
               	jne	<addr>
               	movl	$0x2, %eax
               	movsbq	0x2(%rcx), %rdx
               	cmpl	$-0x2, %edx
               	jne	<addr>
               	movl	$0x3, %eax
               	movsbq	0x3(%rcx), %rcx
               	cmpl	$-0x2, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	leaq	<rip>, %rcx
               	addq	$0x18, %rcx
               	movsbq	0x4(%rcx), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movl	$0x5, %eax
               	movsbq	0x5(%rcx), %rdx
               	cmpl	$0x6, %edx
               	jne	<addr>
               	movl	$0x6, %eax
               	movsbq	0x6(%rcx), %rdx
               	cmpl	$0x7, %edx
               	jne	<addr>
               	movl	$0x7, %eax
               	movsbq	0x7(%rcx), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	xorl	%eax, %eax
               	addq	$0x4, %rcx
               	movsbq	(%rcx), %rdx
               	cmpl	$0x68, %edx
               	je	<addr>
               	addq	$0x1e, %rax
               	retq
               	movl	$0x1, %eax
               	movsbq	0x1(%rcx), %rdx
               	cmpl	$0x65, %edx
               	jne	<addr>
               	movl	$0x2, %eax
               	movsbq	0x2(%rcx), %rdx
               	cmpl	$0x6c, %edx
               	jne	<addr>
               	movl	$0x3, %eax
               	movsbq	0x3(%rcx), %rcx
               	cmpl	$0x6c, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movsbq	0x4(%rcx), %rdx
               	cmpl	$0x6f, %edx
               	jne	<addr>
               	movl	$0x5, %eax
               	cmpb	$0x0, 0x5(%rcx)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x28, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x32, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, 0x8(%rax)
               	je	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x34, %eax
               	retq
               	leaq	0x18(%rax), %rcx
               	movq	0x20(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x35, %eax
               	retq
               	cmpq	$0x0, 0x28(%rax)
               	je	<addr>
               	movq	0x28(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x30(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x36, %eax
               	retq
               	cmpq	$0x0, 0x38(%rax)
               	je	<addr>
               	movq	0x38(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x37, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, 0x40(%rax)
               	je	<addr>
               	movq	0x40(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x48(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x38, %eax
               	retq
               	cmpq	$0x0, 0x50(%rax)
               	je	<addr>
               	movq	0x50(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x39, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, 0x58(%rax)
               	je	<addr>
               	movl	$0x3a, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3c, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x3d, %eax
               	retq
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movq	0x10(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x3e, %eax
               	retq
               	cmpq	$0x0, 0x20(%rax)
               	je	<addr>
               	movq	0x20(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3f, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, 0x28(%rax)
               	je	<addr>
               	movq	0x28(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x30(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x40, %eax
               	retq
               	cmpq	$0x0, 0x38(%rax)
               	je	<addr>
               	movq	0x38(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x41, %eax
               	retq
               	xorl	%eax, %eax
               	retq
