
indirect_struct_return.x64:	file format elf64-x86-64

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

<make>:
               	movq	%rdi, %rax
               	shlq	%rax
               	movl	%edi, %ecx
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	retq

<main>:
               	pushq	%rax
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0x14, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	shrq	$0x20, %rax
               	addq	$0x3, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
