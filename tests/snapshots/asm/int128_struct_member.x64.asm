
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
               	leaq	0x10(%rdi), %rcx
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
               	leaq	-0xb0(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	leaq	0x10(%rdi), %rax
               	movq	%r12, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	(%rax), %rcx
               	movq	0x18(%rdi), %rsi
               	leaq	0x3(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	incq	%rsi
               	addq	%rsi, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
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
               	leaq	-0xb0(%rbp), %rdi
               	leaq	0x10(%rdi), %rax
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	%r12, (%rax)
               	movq	%rbx, 0x8(%rax)
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
