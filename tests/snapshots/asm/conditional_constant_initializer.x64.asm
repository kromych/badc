
conditional_constant_initializer.x64:	file format elf64-x86-64

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

<fa>:
               	movl	$0x1, %eax
               	retq

<fb>:
               	movl	$0x2, %eax
               	retq

<main>:
               	pushq	%rax
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
