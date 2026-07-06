
stdint_min_macros_type_and_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	$0x16, %eax
               	retq
               	movl	$0xa, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
