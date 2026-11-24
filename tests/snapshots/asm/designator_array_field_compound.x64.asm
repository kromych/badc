
designator_array_field_compound.x64:	file format elf64-x86-64

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

<idle>:
               	movl	$0xa, %eax
               	retq

<run>:
               	movl	$0x14, %eax
               	retq

<stop>:
               	movl	$0x1e, %eax
               	retq

<last>:
               	movl	$0x3c, %eax
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x3c, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
