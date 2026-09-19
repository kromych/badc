
int128_struct_member.x64:	file format elf64-x86-64

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

<read_wide>:
               	leaq	0x10(%rdi), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %r12
               	orq	%rcx, %r12
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x20(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movq	0x18(%rax), %rax
               	xorq	%r12, %rcx
               	xorq	%rbx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%r12, %rcx
               	xorq	%rbx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	xorq	%r11, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%r12, %rax
               	xorq	$0x4, %rax
               	movq	%rbx, %rcx
               	xorq	$0x9, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%r12, %rax
               	xorq	%r12, %rax
               	movq	%rbx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movl	$0x1, (%rax)
               	leaq	0x10(%rax), %rcx
               	movq	%r12, (%rcx)
               	movq	%rbx, 0x8(%rcx)
               	movl	$0x2, 0x20(%rax)
               	movq	(%rcx), %rdx
               	movq	0x18(%rax), %rdi
               	leaq	0x3(%rdx), %rsi
               	cmpq	%rdx, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	incq	%rdi
               	addq	%rdi, %rdx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	-0xb0(%rbp), %rdi
               	movslq	(%rdi), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movslq	0x20(%rdi), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	$0x7, %rcx
               	xorq	$0xa, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movq	$0x0, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movslq	(%rax), %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movslq	0x20(%rax), %rdx
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%r12, (%rcx)
               	movq	%rbx, 0x8(%rcx)
               	leaq	-0xb0(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%r12, %rcx
               	xorq	%rbx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
