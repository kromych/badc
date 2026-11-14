
zero_length_local_array.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x5, %eax
               	movabsq	$0x600000005, %rdx      # imm = 0x600000005
               	movq	%rdx, -0x10(%rbp)
               	movl	$0x7, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
