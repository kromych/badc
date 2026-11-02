
array_init_constant_expression.x64:	file format elf64-x86-64

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
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x80, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x90, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x94, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x100, %eax            # imm = 0x100
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x40, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x70, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x30, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x90, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	xorl	%eax, %eax
               	retq
