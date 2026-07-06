
computed_goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rcx
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x10(%rcx)
               	movl	%eax, -0x20(%rbp)
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	0x10(%rbp), %rdx
               	movslq	%eax, %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rdx,%rax,4), %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax
               	movslq	-0x20(%rbp), %rsi
               	movq	0x10(%rbp), %rax
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
               	movq	0x10(%rbp), %rax
               	movslq	-0x28(%rbp), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x28(%rbp)
               	movslq	(%rax,%rcx,4), %rcx
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rsi
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x28(%rbp)
               	movslq	(%rax,%rcx,4), %rax
               	movq	(%rsi,%rax,8), %rax
               	jmpq	*%rax
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
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movslq	%eax, %rax
               	movslq	0x10(%rbp), %rdx
               	cmpq	%rdx, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movzbq	0x18(%rcx), %rdx
               	movb	%dl, 0x18(%rax)
               	movzbq	0x19(%rcx), %rdx
               	movb	%dl, 0x19(%rax)
               	movzbq	0x1a(%rcx), %rdx
               	movb	%dl, 0x1a(%rax)
               	movzbq	0x1b(%rcx), %rdx
               	movb	%dl, 0x1b(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
