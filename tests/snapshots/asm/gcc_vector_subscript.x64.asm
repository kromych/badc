
gcc_vector_subscript.x64:	file format elf64-x86-64

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

<sum4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp,%riz)
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	(%rcx), %ecx
               	addq	$0x0, %rcx
               	movl	%ecx, %ecx
               	movl	0x4(%rax), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	0x8(%rax), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	0xc(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	movl	$0x63, %edx
               	movb	%dl, 0x3(%rax)
               	movl	$0xc8, %edx
               	movb	%dl, 0xa(%rax)
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	xorq	$0x2710, %rax           # imm = 0x2710
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7530, %eax           # imm = 0x7530
               	movl	%eax, 0x8(%rdi)
               	movl	0x8(%rdi), %eax
               	xorq	$0x7530, %rax           # imm = 0x7530
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	xorq	$0x9088, %rax           # imm = 0x9088
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
