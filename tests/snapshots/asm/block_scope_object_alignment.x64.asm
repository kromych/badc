
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
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movl	$0x9, %edx
               	movq	%rdx, (%rsp)
               	leaq	<rip>, %rcx
               	movq	%rcx, %rsi
               	andq	$0xf, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	addq	$0x90, %rsp
               	popq	%rbp
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
               	addq	$0x90, %rsp
               	popq	%rbp
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
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x90(%rbp), %rsp
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x90(%rbp), %rsp
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	andq	$0x7, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x90(%rbp), %rsp
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	andq	$0x7, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0x90(%rbp), %rsp
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	(%rcx), %rax
               	cmpq	$0x1, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x90(%rbp), %rsp
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	cmpq	$0x6, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x90(%rbp), %rsp
               	movq	%rdx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rcx
               	cmpq	$0x9, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0x90(%rbp), %rsp
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	movl	$0xd, %esi
               	movq	%rsi, (%rcx)
               	movq	%fs:0x0, %rdi
               	addq	$-0x10, %rdi
               	movl	$0xe, %r8d
               	movb	%r8b, (%rdi)
               	movq	%fs:0x0, %rdi
               	addq	$-0x8, %rdi
               	movl	$0xf, %r8d
               	movq	%r8, (%rdi)
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
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x63, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x65, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x90(%rbp), %rsp
               	movq	%rsi, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	leaq	-0x90(%rbp), %rsp
               	movq	%rdx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
