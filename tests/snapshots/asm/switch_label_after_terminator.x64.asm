
switch_label_after_terminator.x64:	file format elf64-x86-64

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

<outer>:
               	cmpl	$0x2, %edi
               	jl	<addr>
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x3, %edi
               	je	<addr>
               	movq	$-0x1, %rax
               	retq
               	movl	$0x3, %eax
               	addq	$0x64, %rax
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>

<main>:
               	xorl	%eax, %eax
               	retq
