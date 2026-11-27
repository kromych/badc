
mul_add_contraction.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rsi # <addr>
               	imulq	$0x18, %rax, %r8
               	leaq	(%rsi,%r8), %rdi
               	movl	(%rdi), %ecx
               	movl	0x4(%rdi), %r9d
               	movl	0x8(%rdi), %edx
               	movq	%rcx, %r10
               	imulq	%r9, %r10
               	leaq	(%rdx,%r10), %r11
               	movl	0xc(%rdi), %edi
               	cmpl	%edi, %r11d
               	jne	<addr>
               	leaq	(%rsi,%r8), %rdi
               	movl	0xc(%rdi), %edi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %r11d
               	jne	<addr>
               	movq	%rdx, %r8
               	subq	%r10, %r8
               	imulq	$0x18, %rax, %rdi
               	leaq	(%rsi,%rdi), %r10
               	movl	0x10(%r10), %r10d
               	nop
               	cmpl	%r10d, %r8d
               	jne	<addr>
               	imulq	%r9, %rcx
               	movq	%rcx, %r8
               	subq	%rdx, %r8
               	addq	%rsi, %rdi
               	movl	0x14(%rdi), %r9d
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	subq	%rcx, %rdx
               	movq	%rdx, %r8
               	xorq	%rcx, %r8
               	movl	0x10(%rdi), %edi
               	xorq	%rcx, %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %r8d
               	jne	<addr>
               	imulq	$0x18, %rax, %rcx
               	addq	%rsi, %rcx
               	movl	0x10(%rcx), %ecx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x7, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	(%rdx,%rax,4), %esi
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$0x33, %ecx
               	je	<addr>
               	movl	$0x46, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	(%rdx,%rax,4), %esi
               	subq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$-0x11, %ecx
               	je	<addr>
               	movl	$0x48, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	(%rdx,%rax,4), %esi
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x49, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0xf, %eax
               	retq
               	movl	$0xe, %eax
               	retq
               	movl	$0xd, %eax
               	retq
               	movl	$0xc, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	movl	$0xa, %eax
               	retq
