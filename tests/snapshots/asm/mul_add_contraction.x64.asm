
mul_add_contraction.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x18, %rax, %r8
               	leaq	(%rcx,%r8), %rdx
               	movl	(%rdx), %esi
               	movl	0x4(%rdx), %edi
               	movl	0x8(%rdx), %ecx
               	movq	%rsi, %r9
               	imulq	%rdi, %r9
               	leaq	(%rcx,%r9), %rbx
               	movl	0xc(%rdx), %edx
               	cmpl	%edx, %ebx
               	jne	<addr>
               	leaq	(%r9,%rcx), %rdx
               	leaq	<rip>, %r9 # <addr>
               	addq	%r9, %r8
               	movl	0xc(%r8), %r8d
               	cmpl	%r8d, %edx
               	jne	<addr>
               	movq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	leaq	<rip>, %rbx # <addr>
               	imulq	$0x18, %rax, %r8
               	addq	%r8, %rbx
               	movl	0x10(%rbx), %ebx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movq	%rdx, %r9
               	subq	%rcx, %r9
               	leaq	<rip>, %rbx # <addr>
               	addq	%r8, %rbx
               	movl	0x14(%rbx), %ebx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	xorq	%r9, %rdx
               	movslq	%edx, %rdx
               	leaq	<rip>, %r9 # <addr>
               	addq	%r9, %r8
               	movslq	0x10(%r8), %r8
               	imulq	%rdi, %rsi
               	movslq	%esi, %rdi
               	xorq	%r8, %rdi
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	subq	%rsi, %rcx
               	leaq	<rip>, %rdx # <addr>
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rdx
               	movl	0x10(%rdx), %edx
               	cmpl	%edx, %ecx
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
               	popq	%rbx
               	leave
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
               	leave
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
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
