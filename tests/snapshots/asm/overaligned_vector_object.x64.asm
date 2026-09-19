
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
               	leaq	0x10(%rsp), %rcx
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rsp), %rdx
               	testb	$0x1f, %dl
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq
               	movl	$0x7, %eax
               	movb	%al, -0x8(%rbp)
               	movb	$0x8, -0x20(%rbp)
               	movl	$0xb, (%rcx)
               	movl	$0xd, 0xc(%rcx)
               	movl	$0x11, %esi
               	movl	%esi, 0x4(%rdx)
               	movslq	(%rcx), %rdx
               	movslq	0xc(%rcx), %rcx
               	addq	%rdx, %rcx
               	movq	%rsi, %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x29, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq
               	movsbq	-0x8(%rbp), %rcx
               	movsbq	-0x20(%rbp), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	testb	$0x1f, %cl
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x13, 0x8(%rax)
               	movl	$0x17, %edx
               	movl	%edx, (%rcx)
               	movslq	0x8(%rax), %rax
               	movq	%rdx, %rcx
               	addq	%rcx, %rax
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
               	movsd	(%rax), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
