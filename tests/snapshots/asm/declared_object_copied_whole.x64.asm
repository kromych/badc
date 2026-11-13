
declared_object_copied_whole.x64:	file format elf64-x86-64

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

<chain>:
               	andq	$0x1, %rdi
               	leaq	<rip>, %rax # <addr>
               	movb	$0x0, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movb	%dil, <rip> # <addr>
               	movzbq	(%rax), %r10
               	movb	%r10b, (%rcx)
               	retq

<to_global>:
               	leaq	<rip>, %rax # <addr>
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movq	$0x0, 0x50(%rax)
               	movl	%edi, <rip> # <addr>
               	leaq	0x1(%rdi), %rax
               	movl	%eax, <rip> # <addr>
               	leaq	0x2(%rdi), %rax
               	movl	%eax, <rip> # <addr>
               	leaq	0x3(%rdi), %rax
               	movl	%eax, <rip> # <addr>
               	retq

<to_local>:
               	leaq	0x1(%rdi), %rax
               	imulq	$0x64, %rdi, %rcx
               	addq	%rcx, %rax
               	retq

<through_member>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movups	%xmm14, 0x30(%rdi)
               	movups	%xmm14, 0x40(%rdi)
               	movq	$0x0, 0x50(%rdi)
               	movl	%esi, 0x54(%rdi)
               	leaq	0x1(%rsi), %rax
               	movl	%eax, 0x44(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x2, %rax
               	movb	%al, <rip> # <addr>
               	movzbq	<rip>, %rax # <addr>
               	andq	$-0x2, %rax
               	movb	%al, <rip> # <addr>
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	movzbq	<rip>, %rax # <addr>
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	$0x63, <rip> # <addr>
               	movl	$0x63, <rip> # <addr>
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	cmpl	$0x195, %eax            # imm = 0x195
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	movq	$0x63, -0x48(%rbp)
               	movl	$0x63, -0x4(%rbp)
               	movl	<rip>, %esi # <addr>
               	callq	<addr>
               	cmpq	$0x0, -0x48(%rbp)
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	-0x4(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	-0x14(%rbp), %eax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x28(%rbp)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
