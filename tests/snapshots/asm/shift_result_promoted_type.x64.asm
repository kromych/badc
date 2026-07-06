
shift_result_promoted_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movabsq	$-0x200000000, %rax     # imm = 0xFFFFFFFE00000000
               	sarq	$0x1, %rax
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	shrq	$0x3f, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	shrq	$0x1f, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$-0x10, %rax
               	sarq	$0x2, %rax
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x80, %eax
               	shrq	$0x3, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
