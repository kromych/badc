
init_paren_cond_operator_chain.x64:	file format elf64-x86-64

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
               	movzwq	<rip>, %rax # <addr>
               	xorq	$0xc2c2, %rax           # imm = 0xC2C2
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movzwq	<rip>, %rax # <addr>
               	xorq	$0xc4, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
