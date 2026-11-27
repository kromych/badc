
zero_length_local_array.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x28, %rsp
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x10(%rsp), %rcx
               	movl	$0x5, %eax
               	movabsq	$0x600000005, %rdx      # imm = 0x600000005
               	movq	%rdx, 0x10(%rsp)
               	movl	$0x7, 0x18(%rsp)
               	leaq	0x8(%rsp), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
