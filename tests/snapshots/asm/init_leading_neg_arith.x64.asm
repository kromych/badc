
init_leading_neg_arith.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0xffffb9b0, %ecx       # imm = 0xFFFFB9B0
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	0x18(%rax), %ecx
               	cmpl	$0xffffaba0, %ecx       # imm = 0xFFFFABA0
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	0x28(%rax), %ecx
               	cmpl	$0xffff9dcc, %ecx       # imm = 0xFFFF9DCC
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	0x38(%rax), %eax
               	cmpl	$-0x9, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
