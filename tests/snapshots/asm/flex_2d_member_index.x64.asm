
flex_2d_member_index.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x20(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	%rcx, 0x10(%rsi)
               	movl	%ecx, 0x18(%rsi)
               	movl	$0x4, %eax
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	leaq	0x4(%rsi), %rdi
               	imulq	$0x6, %rax, %r8
               	leaq	(%rdi,%r8), %r9
               	leaq	(%r9), %r12
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdx), %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%r12)
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x1(%r9)
               	addq	%rdi, %r8
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x2(%rdx), %rdi
               	andq	$0xff, %rdi
               	movb	%dil, 0x2(%r8)
               	leaq	0x4(%rsi), %rbx
               	imulq	$0x6, %rax, %r8
               	leaq	(%rbx,%r8), %rdi
               	leaq	0x3(%rdx), %r9
               	andq	$0xff, %r9
               	movb	%r9b, 0x3(%rdi)
               	addq	$0x4, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x4(%rdi)
               	leaq	0x4(%rsi), %rdx
               	leaq	(%rdx,%r8), %rdi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x5, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x5(%rdi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	movzbq	0x15(%rsi), %rax
               	xorq	$0x25, %rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x16(%rsi), %rax
               	xorq	$0x30, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0x10(%rsi), %rax
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x21, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xab, %ecx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x11(%rsi), %rax
               	xorq	$0xab, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0x4(%rsi), %rcx
               	leaq	0x16(%rsi), %rax
               	subq	%rcx, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rsi), %rax
               	imulq	$0x6, %rax, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x20(%rbp), %rax
               	subq	%rax, %rdx
               	cmpq	$0x1c, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addq	$0x0, %rcx
               	movl	$0x77, %edx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x8(%rsi), %rcx
               	xorq	$0x77, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rax), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, (%rcx)
               	movw	%dx, 0x2(%rax)
               	movw	%dx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movw	%dx, 0x6(%rcx)
               	xorq	%rdx, %rdx
               	movw	%dx, 0x8(%rcx)
               	movw	%dx, 0xa(%rcx)
               	movw	%dx, 0xc(%rcx)
               	xorq	%rdx, %rdx
               	movw	%dx, 0xe(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movw	%dx, 0x10(%rcx)
               	movw	%dx, 0x12(%rcx)
               	movw	%dx, 0x14(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x16(%rcx)
               	movw	%dx, 0x18(%rcx)
               	movw	%dx, 0x1a(%rcx)
               	movl	$0x4d, %ecx
               	movw	%cx, 0x18(%rax)
               	movswq	%cx, %rcx
               	cmpq	$0x4d, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0x2(%rax), %rcx
               	addq	$0x18, %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rdx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
