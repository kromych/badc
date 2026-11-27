
fn_ptr_typedef_multi_declarator.x64:	file format elf64-x86-64

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

<wide>:
               	movabsq	$0x123456789, %rax      # imm = 0x123456789
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
