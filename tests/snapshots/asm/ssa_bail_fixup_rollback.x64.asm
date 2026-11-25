
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

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

<core>:
               	movl	(%rcx), %eax
               	movl	0x4(%rcx), %edx
               	movl	0x8(%rcx), %esi
               	movl	0xc(%rcx), %ecx
               	xorq	%rdx, %rax
               	xorq	%rsi, %rax
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rdi)
               	retq

<stream_xor>:
               	subq	$0x58, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	$0x40, %eax
               	movq	%r8, %r12
               	movq	$0x0, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	movzbq	(%rcx), %rdx
               	movb	%dl, 0x10(%rsp)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x11(%rsp)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x12(%rsp)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x13(%rsp)
               	movzbq	0x4(%rcx), %rdx
               	movb	%dl, 0x14(%rsp)
               	movzbq	0x5(%rcx), %rdx
               	movb	%dl, 0x15(%rsp)
               	movzbq	0x6(%rcx), %rdx
               	movb	%dl, 0x16(%rsp)
               	movzbq	0x7(%rcx), %rcx
               	movb	%cl, 0x17(%rsp)
               	movq	%r12, %rdx
               	leaq	0x20(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rcx
               	movb	%cl, (%rbx,%rax)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x40, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	addq	$0x40, %rbx
               	cmpl	$0x40, %eax
               	jae	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x58, %rsp
               	retq

<main>:
               	subq	$0x78, %rsp
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	movb	%al, 0x10(%rsp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0x30(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	leaq	0x8(%rsp), %rcx
               	leaq	0x10(%rsp), %r8
               	callq	<addr>
               	movzbq	0x30(%rsp), %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0x4d, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x78, %rsp
               	retq
