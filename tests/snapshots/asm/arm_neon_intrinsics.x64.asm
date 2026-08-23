
arm_neon_intrinsics.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	imulq	$0x1f, %rcx, %rdx
               	addq	$0x7, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x30(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rcx,%rcx,4), %rdx
               	xorq	$0xc3, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x20(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movq	%rcx, %rdx
               	imulq	%rcx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	-0x40(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	movzbq	(%r8), %r9
               	leaq	-0x30(%rbp), %rbx
               	addq	%rcx, %rbx
               	movzbq	(%rbx), %rbx
               	xorq	%rbx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi)
               	movzbq	(%rsi), %rdx
               	movzbq	(%r8), %rsi
               	leaq	-0x30(%rbp), %rdi
               	addq	%rcx, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movzbq	(%rsi), %rdi
               	andq	$0xff, %rdi
               	movq	%rdi, %r8
               	shlq	%r8
               	movslq	%r8d, %r8
               	andq	$0x80, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1d, %edi
               	xorq	%r8, %rdi
               	movq	%rdi, %r9
               	andq	$0xff, %r9
               	movzbq	(%rsi), %r8
               	movq	%r8, %rdi
               	shlq	%rdi
               	movq	%r8, %rdx
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rdi, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %r9d
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
