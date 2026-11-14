
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
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, (%rcx)
               	movq	$0x1, (%rdx)
               	movq	$0x2, 0x8(%rdx)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	movq	%fs:0x0, %rax
               	addq	$-0x100, %rax
               	movb	$0x1, (%rax)
               	movq	%fs:0x0, %rsi
               	addq	$-0xf0, %rsi
               	movb	$0x2, (%rsi)
               	movq	%fs:0x0, %rdi
               	addq	$-0xd0, %rdi
               	movb	$0x3, (%rdi)
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm0, %xmm1
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
               	movq	0x10(%rcx), %r8
               	addq	%r8, %rdx
               	movq	0x18(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movsbq	(%rax), %rax
               	movsbq	(%rsi), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rdi), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<block_scope_boundaries>:
               	movq	%fs:0x0, %rcx
               	addq	$-0x98, %rcx
               	testb	$0x7, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x80, %rax
               	testb	$0xf, %al
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
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, (%rcx)
               	movq	$0x3, (%rax)
               	movq	$0x4, 0x8(%rax)
               	movq	$0x5, (%rsi)
               	movl	$0x6, %eax
               	movq	%rax, (%rdx)
               	movq	$0x7, 0x8(%rdx)
               	movq	%fs:0x0, %rdx
               	addq	$-0xa0, %rdx
               	movb	$0x1, (%rdx)
               	movq	%fs:0x0, %rsi
               	addq	$-0x90, %rsi
               	movb	$0x2, (%rsi)
               	movq	%fs:0x0, %rsi
               	addq	$-0x70, %rsi
               	movb	$0x3, (%rsi)
               	movq	%fs:0x0, %rdi
               	addq	$-0x60, %rdi
               	movb	$0x4, (%rdi)
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x68, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x80, %rcx
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %r8
               	movq	%fs:0x0, %rcx
               	addq	$-0x50, %rcx
               	movq	(%rcx), %r9
               	addq	%r9, %r8
               	movq	0x8(%rcx), %rcx
               	addq	%r8, %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	retq
               	movsbq	(%rdx), %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0x90, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rsi), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rdi), %rcx
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
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	popq	%rbp
               	jmp	<addr>
