
size_t_is_unsigned.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movq	%rax, %rcx
               	movl	%ecx, %ecx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x33333333, %ecx       # imm = 0x33333333
               	jmp	<addr>
               	addb	%al, (%rax)
