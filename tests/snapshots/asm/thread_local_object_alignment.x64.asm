
thread_local_object_alignment.x64:	file format elf64-x86-64

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

<file_scope_boundaries>:
               	movq	%fs:0x0, %rax
               	addq	$-0xf8, %rax
               	testb	$0x7, %al
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0xe0, %rdx
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0xc0, %rcx
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	0x10(%rcx), %rsi
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, (%rax)
               	movq	$0x1, (%rdx)
               	movq	$0x2, 0x8(%rdx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x100, %rcx
               	movb	$0x1, (%rcx)
               	movq	%fs:0x0, %rdx
               	addq	$-0xf0, %rdx
               	movb	$0x2, (%rdx)
               	movq	%fs:0x0, %rsi
               	addq	$-0xd0, %rsi
               	movb	$0x3, (%rsi)
               	movsd	(%rax), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xe0, %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	addq	%rax, %rsi
               	movq	%fs:0x0, %rax
               	addq	$-0xc0, %rax
               	movq	0x10(%rax), %rdi
               	addq	%rdi, %rsi
               	movq	0x18(%rax), %rax
               	addq	%rsi, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rcx
               	addq	%rcx, %rax
               	addq	$0x3, %rax
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
               	movl	$0x7, %r9d
               	movq	%r9, 0x8(%rdx)
               	movq	%fs:0x0, %rdx
               	addq	$-0xa0, %rdx
               	movb	$0x1, (%rdx)
               	movq	%fs:0x0, %rsi
               	addq	$-0x90, %rsi
               	movb	$0x2, (%rsi)
               	movq	%fs:0x0, %rdi
               	addq	$-0x70, %rdi
               	movb	$0x3, (%rdi)
               	movq	%fs:0x0, %r8
               	addq	$-0x60, %r8
               	movb	$0x4, (%r8)
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
               	movq	(%rcx), %r10
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %r10
               	movq	%fs:0x0, %rcx
               	addq	$-0x50, %rcx
               	movq	(%rcx), %r11
               	addq	%r11, %r10
               	movq	0x8(%rcx), %rcx
               	addq	%r10, %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	retq
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rdi), %rcx
               	addq	%rcx, %rax
               	movsbq	(%r8), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movq	%r9, %rax
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
               	pushq	%rax
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%r11
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%r11
               	retq
               	popq	%r11
               	jmp	<addr>
