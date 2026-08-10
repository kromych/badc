
arm_neon_intrinsics.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	leaq	(%rdx,%rax), %rsi
               	imulq	$0x1f, %rax, %rdx
               	addq	$0x7, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x20(%rbp), %rdx
               	leaq	(%rdx,%rax), %rsi
               	leaq	(%rax,%rax,4), %rdx
               	xorq	$0xc3, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x30(%rbp), %rdx
               	leaq	(%rdx,%rax), %rsi
               	movq	%rax, %rdx
               	imulq	%rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdx
               	addq	%rcx, %rdx
               	leaq	-0x10(%rbp), %rsi
               	addq	%rcx, %rsi
               	movzbq	(%rsi), %rsi
               	leaq	-0x20(%rbp), %rdi
               	addq	%rcx, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	-0x40(%rbp), %rdx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	leaq	-0x10(%rbp), %rsi
               	addq	%rcx, %rsi
               	movzbq	(%rsi), %rsi
               	leaq	-0x20(%rbp), %rdi
               	addq	%rcx, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rdx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	leaq	-0x30(%rbp), %rdx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	shlq	%rdx
               	movslq	%edx, %rsi
               	leaq	-0x30(%rbp), %rdx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	cmpq	%rdx, %rdi
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x2a, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
