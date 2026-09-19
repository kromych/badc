
computed_goto.x64:	file format elf64-x86-64

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

<direct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, -0x20(%rbp)
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	jmpq	*%rax
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	-<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>

<interp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x10(%rax)
               	movl	$0x0, -0x20(%rbp)
               	movl	$0x0, -0x28(%rbp)
               	movq	-0x40(%rbp), %rcx
               	movl	$0x1, -0x28(%rbp)
               	movslq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movslq	-0x20(%rbp), %rsi
               	movq	-0x40(%rbp), %rax
               	movslq	-0x28(%rbp), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x28(%rbp)
               	movslq	(%rax,%rcx,4), %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rsi
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x28(%rbp)
               	movslq	(%rax,%rcx,4), %rax
               	movq	(%rsi,%rax,8), %rax
               	jmpq	*%rax
               	movslq	-0x20(%rbp), %rsi
               	movq	-0x40(%rbp), %rax
               	movslq	-0x28(%rbp), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x28(%rbp)
               	movslq	(%rax,%rcx,4), %rcx
               	subq	%rcx, %rsi
               	movl	%esi, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rsi
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x28(%rbp)
               	movslq	(%rax,%rcx,4), %rax
               	movq	(%rsi,%rax,8), %rax
               	jmpq	*%rax
               	movslq	-0x20(%rbp), %rax
               	leave
               	retq

<loop_to>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	%edi, -0x30(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, 0x8(%rcx)
               	movl	$0x0, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x30(%rbp), %rsi
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	$0x0, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax
               	movq	$0x1, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movzbq	0x18(%rax), %rcx
               	movb	%cl, 0x18(%rdi)
               	movzbq	0x19(%rax), %rcx
               	movb	%cl, 0x19(%rdi)
               	movzbq	0x1a(%rax), %rcx
               	movb	%cl, 0x1a(%rdi)
               	movzbq	0x1b(%rax), %rcx
               	movb	%cl, 0x1b(%rdi)
               	popq	%rcx
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
