
flexible_array_member_2d.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0xc, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x16, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0xa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
