
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
               	movq	%fs:0x0, %rdx
               	addq	$-0xf8, %rdx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0xe0, %rcx
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xc0, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	0x10(%rax), %rsi
               	andq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movabsq	$0x4004000000000000, %rsi # imm = 0x4004000000000000
               	movq	%rsi, %xmm14
               	movsd	%xmm14, (%rdx,%riz)
               	movq	$0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	movq	%fs:0x0, %r9
               	addq	$-0x100, %r9
               	movb	$0x1, (%r9)
               	movq	%fs:0x0, %rdi
               	addq	$-0xf0, %rdi
               	movb	$0x2, (%rdi)
               	movq	%fs:0x0, %r8
               	addq	$-0xd0, %r8
               	movb	$0x3, (%r8)
               	movsd	(%rdx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xe0, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	movq	%fs:0x0, %rax
               	addq	$-0xc0, %rax
               	movq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movsbq	(%r9), %rax
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%fs:0x0, %rdx
               	addq	$-0x98, %rdx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xc0, %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%fs:0x0, %rsi
               	addq	$-0x68, %rsi
               	movq	%rsi, %rcx
               	andq	$0x7, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x50, %rcx
               	movq	%rcx, %rdi
               	andq	$0xf, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm14
               	movsd	%xmm14, (%rdx,%riz)
               	movq	$0x3, (%rax)
               	movq	$0x4, 0x8(%rax)
               	movq	$0x5, (%rsi)
               	movl	$0x6, %esi
               	movq	%rsi, (%rcx)
               	movq	$0x7, 0x8(%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x100, %rcx
               	movb	$0x1, (%rcx)
               	movq	%fs:0x0, %rax
               	addq	$-0xf8, %rax
               	movb	$0x2, (%rax)
               	movq	%fs:0x0, %rbx
               	addq	$-0xf0, %rbx
               	movb	$0x3, (%rbx)
               	movq	%fs:0x0, %r8
               	addq	$-0xd0, %r8
               	movb	$0x4, (%r8)
               	movsd	(%rdx,%riz), %xmm0
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
               	popq	%rbx
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xc0, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rdx
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movq	(%rax), %rdi
               	addq	%rdi, %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	leave
               	retq
               	movsbq	(%rcx), %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0xf8, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movsbq	(%r8), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<wide_array_boundary>:
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	0x10(%rax), %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
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
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
