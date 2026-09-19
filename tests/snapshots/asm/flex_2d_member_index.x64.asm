
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
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	-0x20(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movq	%rax, 0x10(%rdx)
               	movl	%eax, 0x18(%rdx)
               	movl	$0x4, %ecx
               	movl	%ecx, (%rdx)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x4(%rdx), %r8
               	imulq	$0x6, %rax, %rsi
               	leaq	(%r8,%rsi), %r9
               	leaq	(%r9), %rbx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rcx), %rdi
               	movb	%dil, (%rbx)
               	incq	%rcx
               	movb	%cl, 0x1(%r9)
               	addq	%rsi, %r8
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %rdi
               	movb	%dil, 0x2(%r8)
               	leaq	0x4(%rdx), %r8
               	leaq	(%r8,%rsi), %rdi
               	leaq	0x3(%rcx), %rsi
               	movb	%sil, 0x3(%rdi)
               	imulq	$0x6, %rax, %r9
               	leaq	(%r8,%r9), %rsi
               	leaq	0x4(%rcx), %rdi
               	movb	%dil, 0x4(%rsi)
               	addq	$0x5, %rcx
               	movb	%cl, 0x5(%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movzbq	0x15(%rdx), %rax
               	xorq	$0x25, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x16(%rdx), %rax
               	xorq	$0x30, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x10(%rdx), %rax
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x21, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xab, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	0x4(%rdx), %rcx
               	leaq	0x16(%rdx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	(%rdx), %rax
               	imulq	$0x6, %rax, %rax
               	leaq	(%rcx,%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	subq	%rax, %rsi
               	cmpq	$0x1c, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	addq	$0x0, %rcx
               	movl	$0x77, %esi
               	movb	%sil, 0x4(%rcx)
               	leaq	(%rax), %rcx
               	xorl	%edx, %edx
               	movw	%dx, (%rcx)
               	movw	%dx, 0x2(%rax)
               	movw	%dx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movw	%dx, 0x6(%rcx)
               	xorl	%edx, %edx
               	movw	%dx, 0x8(%rcx)
               	movw	%dx, 0xa(%rcx)
               	movw	%dx, 0xc(%rcx)
               	xorl	%edx, %edx
               	movw	%dx, 0xe(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movw	%dx, 0x10(%rcx)
               	movw	%dx, 0x12(%rcx)
               	movw	%dx, 0x14(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorl	%edx, %edx
               	movw	%dx, 0x16(%rcx)
               	movw	%dx, 0x18(%rcx)
               	movw	%dx, 0x1a(%rcx)
               	movl	$0x4d, %ecx
               	movw	%cx, 0x18(%rax)
               	leaq	0x2(%rax), %rcx
               	addq	$0x18, %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdx, %rax
               	popq	%rbx
               	leave
               	retq
