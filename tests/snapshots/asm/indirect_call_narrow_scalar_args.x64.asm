
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
               	movsbq	%cl, %rsi
               	movswq	%cx, %rdi
               	imulq	$0x186a0, %rsi, %rcx    # imm = 0x186A0
               	imulq	$0xa, %rdi, %rdx
               	addq	%rdx, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x186a0, %rsi, %rdx    # imm = 0x186A0
               	imulq	$0xa, %rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x6bcd17, %rax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
