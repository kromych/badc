
branch_fuse_cmp.x64:	file format elf64-x86-64

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

<relational>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jge	<addr>
               	movl	$0x1, %eax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jle	<addr>
               	addq	$0x64, %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rsi
               	jg	<addr>
               	incq	%rax
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdx
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	addq	$0x64, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r8
               	cmpq	%r8, %rdi
               	jae	<addr>
               	incq	%rax
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	cmpq	%r8, %rdi
               	jbe	<addr>
               	addq	$0x64, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x5, %rdi
               	jne	<addr>
               	incq	%rax
               	movq	(%rsi), %rsi
               	cmpq	$0x9, %rsi
               	je	<addr>
               	addq	$0x64, %rax
               	movq	(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	ja	<addr>
               	addq	$0x64, %rax
               	movq	(%rdx), %rcx
               	cmpq	$0x9, %rcx
               	jb	<addr>
               	incq	%rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x64, %eax
               	movq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	incq	%rax
               	movq	(%rdx), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	addq	$0x64, %rax
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	setl	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rsi
               	movl	%eax, (%rsi)
               	testq	%rax, %rax
               	je	<addr>
               	movslq	(%rsi), %rax
               	incq	%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	(%rcx), %rax
               	movq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	setl	%sil
               	movzbq	%sil, %rsi
               	movq	(%rcx), %rax
               	movq	(%rdx), %rcx
               	addq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	jmp	<addr>
               	movl	$0x64, %eax
               	jmp	<addr>
