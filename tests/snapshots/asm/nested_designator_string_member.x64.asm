
nested_designator_string_member.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rdi, %r8
               	leaq	<rip>, %rdx
               	leaq	0x4(%rdx), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpb	$0x0, 0x7(%rdx)
               	jne	<addr>
               	cmpb	$0x0, 0xb(%rdx)
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	0xc(%rdx), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	(%rdx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x77, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x78, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x79, %ecx
               	movb	%cl, 0x6(%rax)
               	movl	$0x7a, %ecx
               	movb	%cl, 0x7(%rax)
               	xorl	%ecx, %ecx
               	movb	%cl, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	leaq	0x6(%r8), %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x4(%r8), %rcx
               	movl	%ecx, (%rax)
               	addq	$0x4, %rax
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
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rdx
               	leaq	0x6(%r8), %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movslq	(%rax), %rcx
               	leaq	0x4(%r8), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
