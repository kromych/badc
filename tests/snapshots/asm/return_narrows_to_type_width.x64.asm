
return_narrows_to_type_width.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<uret>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	orq	$-0x6e000000, %rax      # imm = 0x92000000
               	retq

<sret>:
               	movl	%edi, %eax
               	retq

<hret>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<main>:
               	movl	$0x1, %eax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
