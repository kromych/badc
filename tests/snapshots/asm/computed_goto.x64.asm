
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
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	movslq	%edi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	jmpq	*%rax
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<interp>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x10(%rax)
               	movl	%ecx, -0x20(%rbp)
               	movl	%ecx, -0x28(%rbp)
               	movq	0x10(%rbp), %rdx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rdx,%rcx,4), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x20(%rbp), %rdi
               	movq	0x10(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rdx
               	addq	%rdi, %rdx
               	movl	%edx, -0x20(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x20(%rbp), %rdi
               	movq	0x10(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movl	%edx, -0x20(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x20(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<loop_to>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rax)
               	movl	%edx, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, -0x18(%rbp)
               	movslq	%ecx, %rcx
               	movslq	0x10(%rbp), %rsi
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movq	%rdx, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
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
               	movq	%rdi, %rax
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
