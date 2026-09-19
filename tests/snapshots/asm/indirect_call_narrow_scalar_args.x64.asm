
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
               	movsbq	%al, %rcx
               	movswq	%ax, %rdx
               	imulq	$0x186a0, %rcx, %rcx    # imm = 0x186A0
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x6bcd17, %eax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
