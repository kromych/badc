
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
               	movq	%rdi, %rcx
               	andq	$0x1, %rcx
               	leaq	<rip>, %rax
               	movb	$0x0, (%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %r10
               	movb	%r10b, (%rdx)
               	retq

<to_global>:
               	leaq	<rip>, %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movq	$0x0, 0x50(%rax)
               	movl	%edi, 0x54(%rax)
               	leaq	0x1(%rdi), %rcx
               	movl	%ecx, 0x34(%rax)
               	leaq	0x2(%rdi), %rcx
               	movl	%ecx, 0x38(%rax)
               	leaq	0x3(%rdi), %rcx
               	movl	%ecx, 0x44(%rax)
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
               	leaq	0x44(%rdi), %rax
               	movl	%esi, 0x54(%rdi)
               	leaq	0x1(%rsi), %rcx
               	movl	%ecx, (%rax)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x2, %rcx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x2, %rcx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	$0x63, (%rax)
               	movl	$0x63, 0x50(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x50(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	0x54(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movslq	0x34(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movslq	0x38(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movslq	0x44(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	callq	<addr>
               	cmpl	$0x195, %eax            # imm = 0x195
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	movq	$0x63, 0x10(%rdi)
               	movl	$0x63, 0x54(%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	callq	<addr>
               	leaq	-0x58(%rbp), %rax
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	0x54(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movslq	0x44(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x30(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
