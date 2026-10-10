
c11_atomic_specifier.x64:	file format elf64-x86-64

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
               	movb	$-0x38, -0x10(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0xc8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movb	$-0x6, -0x10(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0xfa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0xfffffff9, -0x10(%rbp) # imm = 0xFFFFFFF9
               	movw	$0xd, -0x8(%rbp)
               	movswq	-0x8(%rbp), %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x15, %eax
               	movl	%eax, -0x10(%rbp)
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
