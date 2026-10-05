
inline_asm_x64_constraint_a.x64:	file format elf64-x86-64

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
               	movl	$0x14, %eax
               	movl	$0x16, %ecx
               	addq	%rcx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	addq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x15, %eax
               	addq	%rax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	addq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	andq	$0xff, %rax
               	cmpq	$0x34, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0xff, %eax
               	andq	$0xff, %rax
               	cmpq	$0xff, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
