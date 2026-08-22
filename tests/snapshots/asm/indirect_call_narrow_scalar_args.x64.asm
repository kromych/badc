
indirect_call_narrow_scalar_args.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rcx
               	movsbq	%cl, %rdx
               	movswq	%cx, %rsi
               	imulq	$0x186a0, %rdx, %rcx    # imm = 0x186A0
               	imulq	$0xa, %rsi, %rdi
               	addq	%rdi, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rdi
               	imulq	$0x186a0, %rdx, %rcx    # imm = 0x186A0
               	imulq	$0xa, %rsi, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x6bcd17, %rax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
