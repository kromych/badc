
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
               	xorl	%ecx, %ecx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movslq	%ecx, %rax
               	imulq	$0x1f, %rax, %rdx
               	addq	$0x7, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rax)
               	leaq	-0x30(%rbp), %rsi
               	leaq	(%rax,%rax,4), %rdx
               	xorq	$0xc3, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rax)
               	leaq	-0x20(%rbp), %rsi
               	movq	%rax, %rdx
               	imulq	%rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movslq	%ecx, %rax
               	leaq	-0x40(%rbp), %rsi
               	movzbq	(%rsi,%rax), %r8
               	leaq	-0x30(%rbp), %rdi
               	movzbq	(%rdi,%rax), %r9
               	xorq	%r9, %r8
               	movb	%r8b, (%rdx,%rax)
               	movzbq	(%rdx,%rax), %r8
               	movzbq	(%rsi,%rax), %rdx
               	movzbq	(%rdi,%rax), %rsi
               	xorq	%rsi, %rdx
               	cmpl	%edx, %r8d
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rsi
               	movq	%rsi, %rdi
               	shlq	%rdi
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	xorq	%rdi, %rsi
               	movq	%rsi, %r8
               	andq	$0xff, %r8
               	movzbq	(%rdx,%rax), %rdi
               	movq	%rdi, %rsi
               	shlq	%rsi
               	movq	%rdi, %rax
               	andq	$0x80, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	xorq	%rsi, %rax
               	andq	$0xff, %rax
               	cmpl	%eax, %r8d
               	je	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
