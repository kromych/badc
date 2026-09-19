
thread_local_object_alignment.x64:	file format elf64-x86-64

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

<file_scope_boundaries>:
               	movq	%fs:0x0, %rcx
               	addq	$-0xf8, %rcx
               	testb	$0x7, %cl
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0xe0, %rdx
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xc0, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	0x10(%rax), %rsi
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movabsq	$0x4004000000000000, %rsi # imm = 0x4004000000000000
               	movq	%rsi, %xmm14
               	movsd	%xmm14, (%rcx)
               	movq	$0x1, (%rdx)
               	movq	$0x2, 0x8(%rdx)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	movq	%fs:0x0, %rax
               	addq	$-0x100, %rax
               	movb	$0x1, (%rax)
               	movq	%fs:0x0, %rdi
               	addq	$-0xf0, %rdi
               	movb	$0x2, (%rdi)
               	movq	%fs:0x0, %r8
               	addq	$-0xd0, %r8
               	movb	$0x3, (%r8)
               	movsd	(%rcx), %xmm0
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0xe0, %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rdx
               	movq	%fs:0x0, %rcx
               	addq	$-0xc0, %rcx
               	movq	0x10(%rcx), %rsi
               	addq	%rsi, %rdx
               	movq	0x18(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movsbq	(%rax), %rax
               	movsbq	(%rdi), %rcx
               	addq	%rcx, %rax
               	movsbq	(%r8), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<block_scope_boundaries>:
               	movq	%fs:0x0, %rax
               	addq	$-0x98, %rax
               	testb	$0x7, %al
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0xc0, %rcx
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%fs:0x0, %rsi
               	addq	$-0x68, %rsi
               	testb	$0x7, %sil
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0x50, %rdx
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm14
               	movsd	%xmm14, (%rax)
               	movq	$0x3, (%rcx)
               	movq	$0x4, 0x8(%rcx)
               	movq	$0x5, (%rsi)
               	movl	$0x6, %ecx
               	movq	%rcx, (%rdx)
               	movq	$0x7, 0x8(%rdx)
               	movq	%fs:0x0, %rdx
               	addq	$-0x100, %rdx
               	movb	$0x1, (%rdx)
               	movq	%fs:0x0, %rsi
               	addq	$-0xf8, %rsi
               	movb	$0x2, (%rsi)
               	movq	%fs:0x0, %rsi
               	addq	$-0xf0, %rsi
               	movb	$0x3, (%rsi)
               	movq	%fs:0x0, %r8
               	addq	$-0xd0, %r8
               	movb	$0x4, (%r8)
               	movsd	(%rax), %xmm0
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x68, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xc0, %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	addq	%rax, %rdi
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movq	(%rax), %r9
               	addq	%r9, %rdi
               	movq	0x8(%rax), %rax
               	addq	%rdi, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	movsbq	(%rdx), %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0xf8, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rsi), %rcx
               	addq	%rcx, %rax
               	movsbq	(%r8), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<wide_array_boundary>:
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	0x10(%rax), %rcx
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	$0x8, 0x20(%rax)
               	movq	%fs:0x0, %rcx
               	addq	$-0x40, %rcx
               	movb	$0x1, (%rcx)
               	movq	0x20(%rax), %rax
               	incq	%rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
