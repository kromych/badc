
block_scope_object_alignment.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x10(%rsp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x9, %edx
               	movq	%rdx, (%rsp)
               	leaq	<rip>, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	<rip>, %rsi
               	andq	$0x1f, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	<rip>, %rsi
               	andq	$0xf, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rsp), %rcx
               	andq	$0x1f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	andq	$0x7, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	andq	$0x7, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x90(%rbp), %rsp
               	movq	%rdx, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	%fs:0x0, %rsi
               	addq	$-0x10, %rsi
               	movl	$0xe, %edi
               	movb	%dil, (%rsi)
               	movq	%fs:0x0, %rsi
               	addq	$-0x8, %rsi
               	movl	$0xf, %edi
               	movq	%rdi, (%rsi)
               	movq	(%rcx), %rcx
               	cmpq	$0xd, %rcx
               	jne	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0xe, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xf, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x63, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x65, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x90(%rbp), %rsp
               	movq	%rdx, %rax
               	leave
               	retq
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
