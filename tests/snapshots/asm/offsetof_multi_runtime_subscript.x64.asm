
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
               	pushq	%rbx
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
               	addq	$0x6, %rdx
               	addq	$0x2, %rdx
               	cmpl	%esi, %edx
               	jne	<addr>
               	addq	$0x4, %rcx
               	shlq	%rcx
               	leaq	0x2(%rcx), %rdx
               	imulq	$0xe, %rax, %rcx
               	leaq	0x8(%rcx), %rsi
               	addq	$0x2, %rsi
               	cmpl	%edx, %esi
               	jne	<addr>
               	imulq	$0x7, %rax, %rdx
               	leaq	0x5(%rdx), %rsi
               	shlq	%rsi
               	addq	$0x2, %rsi
               	leaq	0xa(%rcx), %rdi
               	addq	$0x2, %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
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
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	leaq	(%rbx,%rbx,2), %rsi
               	imulq	$0x18, %rbx, %rdi
               	leaq	(%rsi,%rax), %rcx
               	shlq	%rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	0x48(%rdx), %r8
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdi, %rdx
               	leaq	0x48(%rdx), %r9
               	nopl	(%rax,%rax)
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
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	imulq	$0x18, %rax, %rcx
               	leaq	0x50(%rcx), %rsi
               	imulq	$0x6, %rax, %rdx
               	movq	%rdx, %rdi
               	shlq	$0x2, %rdi
               	addq	$0x50, %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	addq	$0x4, %rcx
               	addq	$0x50, %rcx
               	incq	%rdx
               	shlq	$0x2, %rdx
               	addq	$0x50, %rdx
               	nopl	(%rax,%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	imulq	$0x34, %rbx, %rdx
               	leaq	0xac(%rdx), %rcx
               	leaq	(%rax,%rax,2), %rsi
               	movq	%rsi, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rcx,%rdi), %r8
               	imulq	$0xc, %rax, %rdi
               	addq	%rdx, %rdi
               	leaq	0xac(%rdi), %r9
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	incq	%rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	addq	$0x4, %rdi
               	addq	$0xac, %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	leaq	(%rax,%rax,2), %rsi
               	addq	$0x2, %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	imulq	$0xc, %rax, %rdi
               	addq	%rdx, %rdi
               	addq	$0x8, %rdi
               	addq	$0xac, %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%rbx
               	nopl	(%rax,%rax)
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	retq
