
function_slot_names_no_c_definition.x64:	file format elf64-x86-64

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

<holder>:
               	movl	$0x5, %eax
               	retq
               	retq

<main>:
               	pushq	%rax
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	xorl	%ecx, %ecx
               	movl	$0x3, %edx
               	cmpl	$0x5, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%r11
               	retq
