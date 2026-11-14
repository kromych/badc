
asm_label_names_the_assembler_symbol.x64:	file format elf64-x86-64

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

<asm_label_raw_def>:
               	movl	$0x5, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%bh, 0x2(%rax)

<asm_label_two>:
               	movl	$0x2, %eax
               	retq

<asm_label_raw>:
               	movl	$0x3, %eax
               	retq

<call_five>:
               	jmp	<addr>
