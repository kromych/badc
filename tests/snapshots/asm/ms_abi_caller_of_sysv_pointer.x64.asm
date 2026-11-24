
ms_abi_caller_of_sysv_pointer.x64:	file format elf64-x86-64

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

<callee>:
               	movq	%rdx, <rip> # <addr>
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	retq

<caller>:
               	pushq	%rax
               	movq	%rdi, %rdx
               	movl	$0x7, %eax
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	callq	*%rdx
               	popq	%r11
               	retq

<main>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x28(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x20(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	leaq	-<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	imulq	$0xa, %rax, %rax
               	addq	%rbx, %rax
               	movq	0x20(%rsp), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
