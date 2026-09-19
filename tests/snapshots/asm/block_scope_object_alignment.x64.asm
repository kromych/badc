
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
               	movl	$0x9, %edx
               	movq	%rdx, (%rsp)
               	leaq	<rip>, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	<rip>, %rsi
               	andq	$0x1f, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	<rip>, %rsi
               	andq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rsp), %rcx
               	andq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	andq	$0x7, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	andq	$0x7, %rcx
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
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
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
               	je	<addr>
               	movq	%rdx, %rax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movq	%fs:0x0, %rdx
               	addq	$-0x10, %rdx
               	movl	$0xe, %esi
               	movb	%sil, (%rdx)
               	movq	%fs:0x0, %rdx
               	addq	$-0x8, %rdx
               	movl	$0xf, %esi
               	movq	%rsi, (%rdx)
               	movq	(%rax), %rax
               	cmpq	$0xd, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x65, %eax
               	je	<addr>
               	movq	%rcx, %rax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
