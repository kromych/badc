
computed_goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<direct>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movl	%edi, 0x10(%rbp)
               	movslq	0x10(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	jmpq	*%rax
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
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
               	subq	$0x40, %rsp
               	movq	%r13, (%rsp)
               	movq	%rdi, 0x10(%rbp)
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x10(%rax)
               	movl	%ecx, -0x20(%rbp)
               	movl	%ecx, -0x28(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movslq	-0x20(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rcx
               	addq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movslq	-0x20(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rcx
               	subq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
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
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
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
               	leaq	-0x10(%rbp), %rax
               	movslq	-0x18(%rbp), %rcx
               	movslq	0x10(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movzbq	0x18(%rcx), %r11
               	movb	%r11b, 0x18(%rax)
               	movzbq	0x19(%rcx), %r11
               	movb	%r11b, 0x19(%rax)
               	movzbq	0x1a(%rcx), %r11
               	movb	%r11b, 0x1a(%rax)
               	movzbq	0x1b(%rcx), %r11
               	movb	%r11b, 0x1b(%rax)
               	popq	%r11
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
