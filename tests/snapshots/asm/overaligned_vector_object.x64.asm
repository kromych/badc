
overaligned_vector_object.x64:	file format elf64-x86-64

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

<automatic_boundaries>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x10(%rsp), %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rsp), %rcx
               	movq	%rcx, %rdx
               	andq	$0x1f, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq
               	movl	$0x7, %edx
               	movb	%dl, -0x8(%rbp)
               	movl	$0x8, %esi
               	movb	%sil, -0x20(%rbp)
               	movl	$0xb, %esi
               	movl	%esi, (%rax)
               	movl	$0xd, %esi
               	movl	%esi, 0xc(%rax)
               	movl	$0x11, %esi
               	movl	%esi, 0x4(%rcx)
               	movslq	(%rax), %rdi
               	movslq	0xc(%rax), %rax
               	addq	%rdi, %rax
               	movq	%rsi, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq
               	movsbq	-0x8(%rbp), %rax
               	movsbq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	leaq	-0x50(%rbp), %rsp
               	movq	%rdx, %rax
               	leave
               	retq
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq
               	xorq	%rax, %rax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x1f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x13, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	<rip>, %rcx
               	movl	$0x17, %edx
               	movl	%edx, (%rcx)
               	movslq	0x8(%rax), %rax
               	addq	$0x17, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rdx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
