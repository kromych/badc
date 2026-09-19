
inline_mcpy_flat_path.x64:	file format elf64-x86-64

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

<use_decode>:
               	movq	%rdi, %r8
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rcx), %rax
               	movq	%rax, %rsi
               	shrq	$0x3e, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rdx,%rdi), %rax
               	pushq	%rcx
               	movzbq	(%rax), %rcx
               	movb	%cl, (%r8)
               	movzbq	0x1(%rax), %rcx
               	movb	%cl, 0x1(%r8)
               	popq	%rcx
               	movslq	0x8(%rcx), %r8
               	movzbq	0x2(%rax), %r9
               	addq	%r9, %r8
               	movl	%r8d, 0x8(%rcx)
               	movzbq	0x3(%rax), %rax
               	retq

<use_widen>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x20(%rax), %rax
               	incq	%rcx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	retq

<use_preset>:
               	movl	$0x475, %eax            # imm = 0x475
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movw	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	%rdx, (%rax)
               	movl	$0x0, 0x8(%rax)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	xorq	$0x1e, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0x3333, %rax           # imm = 0x3333
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x435, %rax            # imm = 0x435
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0xb, %edi
               	callq	<addr>
               	cmpq	$0x475, %rax            # imm = 0x475
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
