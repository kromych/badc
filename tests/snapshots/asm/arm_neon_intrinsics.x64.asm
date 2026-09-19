
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
               	leaq	-0x40(%rbp), %rcx
               	imulq	$0x1f, %rax, %rdx
               	addq	$0x7, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	leaq	-0x30(%rbp), %rcx
               	leaq	(%rax,%rax,4), %rdx
               	xorq	$0xc3, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, %rdx
               	imulq	%rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	movzbq	(%rsi,%rax), %r8
               	leaq	-0x30(%rbp), %rdi
               	movzbq	(%rdi,%rax), %r9
               	xorq	%r9, %r8
               	movb	%r8b, (%rcx,%rax)
               	movzbq	(%rcx,%rax), %rcx
               	movzbq	(%rsi,%rax), %rsi
               	movzbq	(%rdi,%rax), %rdi
               	xorq	%rdi, %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rsi
               	movq	%rsi, %rdi
               	shlq	%rdi
               	testb	$-0x80, %sil
               	je	<addr>
               	movl	$0x1d, %esi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movzbq	(%rcx,%rax), %rcx
               	movq	%rcx, %rdi
               	shlq	%rdi
               	testb	$-0x80, %cl
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rdi, %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %esi
               	je	<addr>
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	%rdx, %rsi
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
