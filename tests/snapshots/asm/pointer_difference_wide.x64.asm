
pointer_difference_wide.x64:	file format elf64-x86-64

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

<d12>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movabsq	$0x2aaaaaaaaaaaaaab, %rcx # imm = 0x2AAAAAAAAAAAAAAB
               	imulq	%rcx
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	retq

<d16>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	sarq	$0x4, %rax
               	retq

<d4>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movabsq	$0x100000000000, %rax   # imm = 0x100000000000
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rbx
               	movabsq	$0x600000000, %r12      # imm = 0x600000000
               	addq	%rbx, %r12
               	movabsq	$0x800000000, %r13      # imm = 0x800000000
               	addq	%rbx, %r13
               	movabsq	$0x3ffffffffc, %r14     # imm = 0x3FFFFFFFFC
               	addq	%rbx, %r14
               	leaq	-0x38(%rbp), %rcx
               	leaq	0x24(%rcx), %rax
               	subq	%rcx, %rax
               	movabsq	$0x2aaaaaaaaaaaaaab, %rsi # imm = 0x2AAAAAAAAAAAAAAB
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	0x24(%rax), %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r13, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	movabsq	$-0xfffffffff, %r11     # imm = 0xFFFFFFF000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
