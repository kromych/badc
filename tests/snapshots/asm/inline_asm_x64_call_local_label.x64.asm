
inline_asm_x64_call_local_label.x64:	file format elf64-x86-64

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

<backward>:
               	jmp	<addr>
               	movl	$0x7, %eax
               	retq
               	callq	<addr>
               	movl	%eax, %ecx
               	movq	%rcx, %rax
               	retq

<forward>:
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x23, %eax
               	retq
               	movl	%eax, %ecx
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	popq	%rbx
               	retq
