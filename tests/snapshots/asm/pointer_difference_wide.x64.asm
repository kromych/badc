
pointer_difference_wide.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	%rsi, %rdi
               	movabsq	$0x2aaaaaaaaaaaaaab, %rcx # imm = 0x2AAAAAAAAAAAAAAB
               	movq	%rdi, %rax
               	imulq	%rcx
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	retq

<d16>:
               	subq	%rsi, %rdi
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3c, %rax
               	addq	%rdi, %rax
               	sarq	$0x4, %rax
               	retq

<d4>:
               	subq	%rsi, %rdi
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rdi, %rax
               	sarq	$0x2, %rax
               	retq

<main>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	movabsq	$0x100000000000, %rax   # imm = 0x100000000000
               	movq	%rax, 0x68(%rsp)
               	movq	0x68(%rsp), %rbx
               	movabsq	$0x600000000, %r8       # imm = 0x600000000
               	addq	%rbx, %r8
               	movabsq	$0x800000000, %r10      # imm = 0x800000000
               	addq	%rbx, %r10
               	movq	%r10, 0x28(%rsp)
               	movabsq	$0x3ffffffffc, %r10     # imm = 0x3FFFFFFFFC
               	addq	%rbx, %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	0x38(%rsp), %rcx
               	leaq	0x24(%rcx), %rsi
               	movq	%rsi, %rax
               	subq	%rcx, %rax
               	movabsq	$0x2aaaaaaaaaaaaaab, %rdi # imm = 0x2AAAAAAAAAAAAAAB
               	imulq	%rdi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	subq	%rsi, %rcx
               	movq	%rcx, %rax
               	imulq	%rdi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%r8, 0x18(%rsp)
               	movq	%r8, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %r8
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r8, %rsi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rsi
               	movq	0x28(%rsp), %rdi
               	callq	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	0x28(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rsi
               	movq	0x20(%rsp), %rdi
               	callq	<addr>
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	movabsq	$-0xfffffffff, %r11     # imm = 0xFFFFFFF000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
