
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
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x18, %rax, %r8
               	leaq	(%rcx,%r8), %rsi
               	movl	(%rsi), %edx
               	movl	0x4(%rsi), %edi
               	movl	0x8(%rsi), %ecx
               	movq	%rdx, %r9
               	imulq	%rdi, %r9
               	leaq	(%rcx,%r9), %rbx
               	movl	0xc(%rsi), %esi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	leaq	(%r9,%rcx), %rsi
               	leaq	<rip>, %r9 # <addr>
               	addq	%r9, %r8
               	movl	0xc(%r8), %r8d
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movq	%rdx, %rsi
               	imulq	%rdi, %rsi
               	movq	%rcx, %r9
               	subq	%rsi, %r9
               	leaq	<rip>, %rbx # <addr>
               	imulq	$0x18, %rax, %r8
               	addq	%r8, %rbx
               	movl	0x10(%rbx), %ebx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movq	%rsi, %r9
               	subq	%rcx, %r9
               	leaq	<rip>, %rbx # <addr>
               	addq	%r8, %rbx
               	movl	0x14(%rbx), %ebx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movq	%rcx, %r9
               	subq	%rsi, %r9
               	xorq	%rsi, %r9
               	leaq	<rip>, %rsi # <addr>
               	addq	%r8, %rsi
               	movl	0x10(%rsi), %esi
               	imulq	%rdi, %rdx
               	xorq	%rdx, %rsi
               	cmpl	%esi, %r9d
               	jne	<addr>
               	subq	%rdx, %rcx
               	leaq	<rip>, %rdx # <addr>
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rdx
               	movl	0x10(%rdx), %edx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
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
               	popq	%rbx
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
               	popq	%rbx
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
               	popq	%rbx
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	retq
