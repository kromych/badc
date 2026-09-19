
flexible_array_member_after_tentative_def.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movq	0x10(%rdx), %rax
               	cmpq	$0x16, %rax
               	jne	<addr>
               	movq	0x10(%rsi), %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%rdi), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	(%rsi), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x8(%rdi), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movq	0x8(%rdx), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	0x8(%rsi), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	0x18(%rdi), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	0x18(%rdx), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	0x18(%rsi), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	0x28(%rdi), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	0x28(%rdx), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x30(%rdx), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x38(%rdx), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	0x28(%rsi), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x30(%rsi), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %r8
               	movsbq	(%rcx), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	0x40(%rdx), %r8
               	cmpq	%r8, %rdi
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x30(%rdi), %rcx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x38(%rsi), %r9
               	cmpq	%r9, %rdi
               	jae	<addr>
               	leaq	0x30(%rdi), %rcx
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	%r9, %rdx
               	jae	<addr>
               	cmpq	%r8, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
