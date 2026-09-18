
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	<rip>, %r9
               	imulq	$0x18, %r8, %rbx
               	leaq	(%r9,%rbx), %rdx
               	movslq	(%rdx), %rax
               	movslq	0x4(%rdx), %rcx
               	movslq	0x8(%rdx), %rdx
               	movq	%rax, %rdi
               	imulq	%rcx, %rdi
               	leaq	(%rdx,%rdi), %r12
               	leaq	(%r9,%rbx), %r8
               	movslq	0xc(%r8), %r8
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	leaq	(%rdi,%rdx), %r8
               	leaq	<rip>, %r12
               	movl	%esi, %r9d
               	imulq	$0x18, %r9, %rbx
               	addq	%rbx, %r12
               	movslq	0xc(%r12), %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	leaq	<rip>, %r8
               	addq	%rbx, %r8
               	movslq	0x10(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movq	%rax, %rdi
               	imulq	%rcx, %rdi
               	movq	%rdi, %r8
               	subq	%rdx, %r8
               	leaq	<rip>, %r12
               	movl	%esi, %r9d
               	imulq	$0x18, %r9, %rbx
               	addq	%rbx, %r12
               	movslq	0x14(%r12), %r12
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movq	%rdx, %r8
               	subq	%rdi, %r8
               	xorq	%rdi, %r8
               	movslq	%r8d, %r12
               	leaq	<rip>, %r8
               	addq	%rbx, %r8
               	movslq	0x10(%r8), %r8
               	movslq	%edi, %rdi
               	xorq	%r8, %rdi
               	cmpq	%rdi, %r12
               	jne	<addr>
               	movq	%rax, %rdi
               	imulq	%rcx, %rdi
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movslq	%edi, %rdi
               	leaq	<rip>, %r8
               	movl	%esi, %r9d
               	imulq	$0x18, %r9, %r9
               	addq	%r9, %r8
               	movslq	0x10(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	movq	%rdx, %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	%esi, %eax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, %r8d
               	cmpl	$0x7, %r8d
               	jb	<addr>
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$0x33, %ecx
               	je	<addr>
               	movl	$0x46, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	testl	%eax, %eax
               	jl	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x47, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	imulq	$-0x1, %rsi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$-0x11, %ecx
               	je	<addr>
               	movl	$0x48, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x49, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
