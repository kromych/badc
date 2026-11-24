
stack_argument_int_local_widens_to_long.x64:	file format elf64-x86-64

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

<tail>:
               	movq	0x8(%rsp), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movq	0x10(%rsp), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	retq

<pick>:
               	movq	0x20(%rsp), %rax
               	retq

<main>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movslq	%edi, %rbx
               	movq	%rbx, %rax
               	negq	%rax
               	movslq	%eax, %rax
               	imulq	$-0x2, %rbx, %rcx
               	movslq	%ecx, %rcx
               	imulq	$-0x3, %rbx, %rdx
               	movslq	%edx, %rdx
               	imulq	$-0x4, %rbx, %rsi
               	movslq	%esi, %rsi
               	xorl	%edi, %edi
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	imulq	$-0x4d2, %rbx, %rcx     # imm = 0xFB2E
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	movq	$-0x7fffffff, %rax      # imm = 0x80000001
               	testl	%ebx, %ebx
               	setg	%cl
               	movzbq	%cl, %rcx
               	subq	%rcx, %rax
               	xorl	%edi, %edi
               	movq	%rdi, (%rsp)
               	movq	%rdi, 0x8(%rsp)
               	movq	%rdi, 0x10(%rsp)
               	movq	%rax, 0x18(%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
