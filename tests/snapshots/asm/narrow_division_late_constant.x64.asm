
narrow_division_late_constant.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<urem>:
               	movl	$0x7, %eax
               	retq

<udiv>:
               	movl	$0x32, %eax
               	retq

<udiv_wide>:
               	movl	$0xfffffff, %eax        # imm = 0xFFFFFFF
               	retq

<sdiv>:
               	movl	$0xffffffeb, %eax       # imm = 0xFFFFFFEB
               	retq

<srem>:
               	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x32, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0xfffffff, %eax        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$-0x15, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
