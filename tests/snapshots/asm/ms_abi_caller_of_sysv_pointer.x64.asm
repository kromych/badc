
ms_abi_caller_of_sysv_pointer.x64:	file format elf64-x86-64

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

<callee>:
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdx, (%rax)
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	retq

<caller>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rdx
               	leaq	-0x10(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rsi, -0x10(%rbp)
               	movq	$0x7, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	*%rdx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	leaq	-<rip>, %rdi       # <addr>
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	jne	<addr>
               	imulq	$0xa, %r12, %rax
               	addq	%rbx, %rax
               	imulq	$0x64, %r13, %rcx
               	addq	%rcx, %rax
               	imulq	$0x3e8, %r14, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
