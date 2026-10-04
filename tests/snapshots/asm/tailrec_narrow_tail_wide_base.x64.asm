
tailrec_narrow_tail_wide_base.x64:	file format elf64-x86-64

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

<wide_base>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	decq	%rdi
               	callq	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movabsq	$0x10000000000, %rax    # imm = 0x10000000000
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
