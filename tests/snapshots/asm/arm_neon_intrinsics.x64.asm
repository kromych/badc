
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
               	subq	$0x40, %rsp
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rdx
               	imulq	$0x1f, %rax, %rcx
               	addq	$0x7, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	-0x30(%rbp), %rdx
               	leaq	(%rax,%rax,4), %rcx
               	xorq	$0xc3, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, %rcx
               	imulq	%rax, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movzbq	(%rdx,%rax), %r8
               	leaq	-0x30(%rbp), %rsi
               	movzbq	(%rsi,%rax), %r9
               	xorq	%r9, %r8
               	movb	%r8b, (%rcx,%rax)
               	movzbq	(%rcx,%rax), %r8
               	movzbq	(%rdx,%rax), %rcx
               	movzbq	(%rsi,%rax), %rdx
               	xorq	%rdx, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	movq	%rdx, %r8
               	andq	$0xff, %r8
               	movzbq	(%rcx,%rax), %rsi
               	movq	%rsi, %rdx
               	shlq	%rdx
               	movq	%rsi, %rcx
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rdx, %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
