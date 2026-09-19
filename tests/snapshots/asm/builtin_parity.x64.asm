
builtin_parity.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	$0x1234, -0x8(%rbp)     # imm = 0x1234
               	movl	-0x8(%rbp), %eax
               	popcntl	%eax, %eax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	$0xf0f0, -0x10(%rbp)    # imm = 0xF0F0
               	movq	-0x10(%rbp), %rax
               	popcntq	%rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
