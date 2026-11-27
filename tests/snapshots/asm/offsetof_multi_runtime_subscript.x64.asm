
offsetof_multi_runtime_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	xorl	%eax, %eax
               	imulq	$0x7, %rax, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	0x2(%rdx), %rdi
               	imulq	$0xe, %rax, %rdx
               	leaq	0x2(%rdx), %rsi
               	nop
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	0x1(%rcx), %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	addq	$0x2, %rsi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	0x2(%rcx), %rsi
               	shlq	%rsi
               	addq	$0x2, %rsi
               	leaq	0x4(%rdx), %rdi
               	addq	$0x2, %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	leaq	0x3(%rcx), %rsi
               	shlq	%rsi
               	addq	$0x2, %rsi
               	leaq	0x6(%rdx), %rdi
               	addq	$0x2, %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	leaq	0x4(%rcx), %rsi
               	shlq	%rsi
               	addq	$0x2, %rsi
               	addq	$0x8, %rdx
               	addq	$0x2, %rdx
               	cmpl	%esi, %edx
               	jne	<addr>
               	addq	$0x5, %rcx
               	shlq	%rcx
               	leaq	0x2(%rcx), %rdx
               	imulq	$0xe, %rax, %rcx
               	leaq	0xa(%rcx), %rsi
               	addq	$0x2, %rsi
               	cmpl	%edx, %esi
               	jne	<addr>
               	imulq	$0x7, %rax, %rdx
               	addq	$0x6, %rdx
               	shlq	%rdx
               	addq	$0x2, %rdx
               	addq	$0xc, %rcx
               	addq	$0x2, %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorl	%r10d, %r10d
               	xorl	%eax, %eax
               	leaq	(%r10,%r10,2), %rsi
               	imulq	$0x18, %r10, %rdi
               	leaq	(%rsi,%rax), %rcx
               	shlq	%rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	0x48(%rdx), %r8
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdi, %rdx
               	leaq	0x48(%rdx), %r9
               	nopl	(%rax)
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	incq	%rcx
               	shlq	$0x2, %rcx
               	addq	$0x48, %rcx
               	addq	$0x4, %rdx
               	addq	$0x48, %rdx
               	nopl	(%rax)
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x4, %r10d
               	jl	<addr>
               	xorl	%eax, %eax
               	imulq	$0x18, %rax, %rcx
               	leaq	0x50(%rcx), %rsi
               	imulq	$0x6, %rax, %rdx
               	movq	%rdx, %rdi
               	shlq	$0x2, %rdi
               	addq	$0x50, %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	addq	$0x4, %rcx
               	leaq	0x50(%rcx), %rsi
               	leaq	0x1(%rdx), %rcx
               	shlq	$0x2, %rcx
               	addq	$0x50, %rcx
               	nopl	(%rax)
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%r10d, %r10d
               	xorl	%eax, %eax
               	imulq	$0x34, %r10, %rsi
               	leaq	0xac(%rsi), %rcx
               	leaq	(%rax,%rax,2), %rdx
               	movq	%rdx, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rcx,%rdi), %r8
               	imulq	$0xc, %rax, %rdi
               	addq	%rsi, %rdi
               	leaq	0xac(%rdi), %r9
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	leaq	0x1(%rdx), %r8
               	shlq	$0x2, %r8
               	addq	%rcx, %r8
               	addq	$0x4, %rdi
               	addq	$0xac, %rdi
               	cmpl	%r8d, %edi
               	jne	<addr>
               	addq	$0x2, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	imulq	$0xc, %rax, %rdi
               	addq	%rsi, %rdi
               	addq	$0x8, %rdi
               	addq	$0xac, %rdi
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r10
               	nopw	(%rax,%rax)
               	cmpl	$0x3, %r10d
               	jl	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	retq
