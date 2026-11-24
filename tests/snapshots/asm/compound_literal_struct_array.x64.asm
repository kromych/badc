
compound_literal_struct_array.x64:	file format elf64-x86-64

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
               	subq	$0x58, %rsp
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x10(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x14(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x58, %rsp
               	retq
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x58, %rsp
               	retq
               	cmpl	$0x0, 0x10(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x14(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x58, %rsp
               	retq
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x10(%rax), %ecx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movl	0x14(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x10(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x14(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x18(%rax), %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x1c(%rax), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movsbq	0x8(%rax), %rcx
               	cmpl	$0x78, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0xc(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movsbq	0x14(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	0x10(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x1c(%rax), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	0x18(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	0x10(%rsp), %rcx
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rsi
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, 0x20(%rsp)
               	movabsq	$0x600000005, %rax      # imm = 0x600000005
               	movq	%rax, 0x28(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rsi, %rdx
               	movl	(%rdx), %edi
               	imulq	$0xa, %rdi, %rdi
               	movl	0x4(%rdx), %edx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpl	$0x5a, %ecx
               	je	<addr>
               	movl	$0x36, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	0x38(%rsp), %rsi
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rsi, %rdx
               	movl	(%rdx), %edi
               	imulq	$0xa, %rdi, %rdi
               	movl	0x4(%rdx), %edx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x66, %ecx
               	je	<addr>
               	movl	$0x38, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
