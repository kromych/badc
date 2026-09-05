
anon_union_nested_init.x64:	file format elf64-x86-64

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

<check_const>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	retq

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<check_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movb	%bl, (%rax)
               	movb	%r12b, 0x1(%rax)
               	leaq	(%rbx,%r12), %rcx
               	movb	%cl, 0x2(%rax)
               	movq	%rbx, %rcx
               	imulq	%r12, %rcx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movzbq	(%rcx), %rax
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x3(%rcx), %rcx
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	andq	$0xff, %rax
               	cmpl	%eax, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x9, %ecx
               	movb	%cl, (%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	%ebx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %edx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x3(%rcx), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpl	%ebx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0x3, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdi
               	movslq	-0x8(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
